local html = require "site.html"
local post = require "site.post"
local file = require "site.file"
local rss = require "site.rss"
local css = require "site.css"
local sitemap = require "site.sitemap"

local pages = require "blog.pages"
local styles = require "blog.styles"
local blog = {}

local site_url = "https://olexsmir.github.io"
local output_dir = "build"
local assets_dir = "assets"
local posts_dir = "posts"

local function prepare()
  if file.is_dir(output_dir) then
    vim.print("deleting " .. output_dir)
    file.rm(output_dir)
  end
  vim.print("mkdir-ing " .. output_dir)
  file.mkdir(output_dir)

  vim.print("copying " .. assets_dir)
  file.copy(assets_dir, vim.fs.joinpath(output_dir, assets_dir))
end

local function write(fpath, data)
  local path = vim.fs.joinpath(output_dir, fpath)

  vim.print("writing " .. path)
  file.write(path, data)
end

local function write_page(fpath, node)
  write(fpath, html.render_page(node))
end

function blog.build()
  ---@type site.Post[]
  local posts = vim
    .iter(file.list_dir(posts_dir))
    :map(function(fname)
      return post.read_file(posts_dir .. "/" .. fname)
    end)
    :totable()
  post.sort_by_date(posts)

  ---@type site.Post[]
  local recent_posts = vim.iter(posts):slice(1, 5):totable()

  prepare()

  -- stylua: ignore
  write("feed.xml", rss.rss(posts, {
    email = "olexsmir@cock.li",
    name = "olexsmir",
    title = "olexsmir's blog",
    subtitle = "olexsmir's blog feed",
    feed_url = site_url .. "/feed.xml",
    home_url = site_url,
  }))

  write("sitemap.xml", sitemap.sitemap(posts, { site_url = site_url }))
  write("style.css", css.style(styles))
  write_page("404.html", pages.not_found())
  write_page("index.html", pages.home(recent_posts))
  write_page("posts.html", pages.posts(posts))

  for _, p in pairs(posts) do
    write(p.meta.slug .. ".html", html.render_page(pages.post(p)))
  end
end

return blog
