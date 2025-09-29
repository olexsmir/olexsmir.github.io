local html = require "site.html"
local post = require "site.post"
local file = require "site.file"
local rss = require "site.rss"
local css = require "site.css"

local pages = require "blog.pages"
local styles = require "blog.styles"
local blog = {}

local site_url = "https://olexsmir.github.io"
local output_dir = "build"
local posts_dir = "posts"

local function prepare()
  if vim.uv.fs_stat(output_dir).type == "directory" then
    vim.print("deleting " .. output_dir)
    file.rm(output_dir)
  end
  vim.print("mkdir-ing " .. output_dir)
  file.mkdir(output_dir)
end

local function write(fpath, data)
  local path = vim.fs.joinpath(output_dir, fpath)

  vim.print("writing " .. path)
  file.write(path, data)
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
  vim.print(posts)

  -- stylua: ignore
  write("feed.xml", rss.rss(posts, {
    email = "olexsmir@cock.li",
    name = "olexsmir",
    title = "olexsmir",
    feed_url = site_url .. "/feed.xml",
    home_url = site_url,
  }))

  write("style.css", css.style(styles))
  write("404.html", html.render_page(pages.not_found()))
  write("index.html", html.render_page(pages.home(recent_posts)))

  for _, p in pairs(posts) do
    write(p.meta.slug .. ".html", html.render_page(pages.post(p.meta.title, "", p.content)))
  end
end

return blog
