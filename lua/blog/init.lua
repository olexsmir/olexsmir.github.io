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

function blog.build()
  local posts = vim
    .iter(file.list_dir(posts_dir))
    :map(function(fname)
      return post.read_file(posts_dir .. "/" .. fname)
    end)
    :totable()
  post.sort_by_date(posts)

  file.write(
    vim.fs.joinpath(output_dir, "feed.xml"),
    rss.rss({
      email = "olexsmir@cock.li",
      name = "olexsmir",
      title = "olexsmir",
      feed_url = site_url .. "/feed.xml",
      home_url = site_url,
    }, posts)
  )
  file.write(vim.fs.joinpath(output_dir, "404.html"), html.render_page(pages.not_found()))
  file.write(vim.fs.joinpath(output_dir, "style.css"), css.style(styles))
end

return blog
