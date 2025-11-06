local css = require "site.css"
local file = require "site.file"
local highlighter = require "site.highlighter"
local html = require "site.html"
local post = require "site.post"
local rss = require "site.rss"
local sitemap = require "site.sitemap"

local pages = require "blog.pages"
local styles = require "blog.styles"
local c = require "blog.config"
local blog = {}

local function write(fpath, data)
  file.write({ c.build.output, fpath }, data)
end

local function write_page(fpath, node)
  write(fpath, html.render_page(node))
end

function blog.build()
  --- clean up
  if file.is_dir(c.build.output) then
    file.rm(c.build.output)
  end
  file.mkdir(c.build.output)
  file.copy_dir(c.build.assets, vim.fs.joinpath(c.build.output, c.build.assets))

  -- write the pages
  ---@type site.Post[]
  local posts = vim
    .iter(file.list_dir(c.build.posts))
    :map(function(fname)
      return post.read_file { c.build.posts, fname }
    end)
    :totable()
  post.sort_by_date(posts)

  write("sitemap.xml", sitemap.sitemap(posts, { site_url = c.url }))
  write("style.css", css.style(styles))
  write("chroma.css", highlighter.css())
  write("CNAME", c.cname)
  write_page("404.html", pages.not_found())
  write_page("index.html", pages.home())
  write_page("posts.html", pages.posts(posts))

  -- stylua: ignore
  write("feed.xml", rss.rss(posts, {
    email = c.email,
    name = c.name,
    title = c.title,
    subtitle = c.feed.subtitle;
    feed_url = c.feed.url,
    home_url = c.url,
  }))

  for _, p in pairs(posts) do
    local phtml = html.render_page(pages.post(p))
    phtml = highlighter.html(phtml)
    write(p.meta.slug .. ".html", phtml)
  end
end

return blog
