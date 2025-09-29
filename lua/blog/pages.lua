local h = require "site.html"
local a = require "site.html.attribute"
local pages = {}

local function meta_property(property, content)
  return h.meta {
    a.attr("property", property),
    a.attr("content", content),
  }
end

---@param page_title string
---@param page_desc string
---@param body site.HtmlNote[]
---@return site.HtmlNote
local function with_body(page_title, page_desc, body)
  return h.el("html", { a.attr("lang", "en") }, {
    h.el("head", {}, {
      h.el("title", {}, { h.text(page_title) }),
      h.meta { a.attr("charset", "utf-8") },
      h.meta {
        a.attr("name", "viewport"),
        a.attr("content", "width=device-width, initial-scale=1.0, viewport-fit=cover"),
      },
      h.el("link", {
        a.attr("rel", "alternate"),
        a.attr("type", "application/rss+xml"),
        a.attr("title", "olexsmir.github.io posts feed"),
        a.href "olexsmir.github.io/feed.xml",
      }, {}),
      h.el("link", {
        a.attr("rel", "stylesheet"),
        a.href "style.css",
      }, {}),
      h.meta { a.attr("description", page_desc) },
      meta_property("og:description", page_desc),
      meta_property("og:site_name", "olexsmir's blog"),
      meta_property("og:title", page_title),
      meta_property("og:type", "website"),
    }),
    h.el("body", {}, body),
  })
end

function pages.not_found()
  return with_body("Not found", "There's nothing here", {
    h.main({}, {
      h.el("h1", {}, { h.text "There's nothing here!" }),
      h.p({}, {
        h.text "Go pack to the ",
        h.el("a", { a.href "/" }, { h.text "home page" }),
      }),
    }),
  })
end

return pages
