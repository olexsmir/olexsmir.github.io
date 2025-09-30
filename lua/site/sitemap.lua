local h = require "site.html"
local a = require "site.html.attribute"
local formatDate = require("site.date").date
local sitemap = {}

local function url(url_, date, priority)
  return h.el("url", {}, {
    h.el("loc", {}, { h.text(url_) }),
    h.el("lastmod", {}, { h.text(formatDate(date)) }),
    h.el("priority", {}, { h.text(priority) }),
  })
end

---@param posts site.Post[]
---@param config {site_url:string}
---@return string
function sitemap.sitemap(posts, config)
  local urls = vim
    .iter(posts)
    ---@param post site.Post
    :map(function(post)
      return url(config.site_url .. "/" .. post.meta.slug, post.meta.date, "0.80")
    end)
    :totable()

  return h.render(
    h.el("urlset", { a.attr("xmlns", "http://www.sitemaps.org/schemas/sitemap/0.9") }, {
      url(config.site_url, posts[1].meta.date, "1.0"),
      unpack(urls),
    })
  )
end

return sitemap
