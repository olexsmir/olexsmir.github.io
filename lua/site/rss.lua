local h = require "site.html"
local date = require("site.date").date
local a = require "site.html.attribute"
local rss = {}

function rss.escape_html(html)
  local map = {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ['"'] = "&quot;",
    ["'"] = "&#39;",
  }
  -- Remove or replace problematic characters
  html = html:gsub("[\r\n\t]", " ") -- Convert whitespace to spaces
  html = html:gsub("[%z\1-\8\11-\12\14-\31]", "") -- Remove control chars

  return (html:gsub("[&<>\"']", function(c)
    return map[c]
  end))
end

---@param config {feed_url:string, home_url:string, title:string, name:string, email:string, subtitle:string}
---@param posts site.Post[]
---@return string
function rss.rss(posts, config)
  local entries = vim
    .iter(posts)
    ---@param post site.Post
    :map(function(post)
      return h.el("entry", {}, {
        h.el("title", {}, { h.text(post.meta.title) }),
        h.el("link", { a.href(config.home_url .. "/" .. post.meta.slug) }, {}),
        h.el("id", {}, { h.text(config.home_url .. "/" .. post.meta.slug) }),
        h.el("updated", {}, { h.text(date(post.meta.date)) }),
        h.el("content", { a.attr("type", "html") }, { h.raw(rss.escape_html(post.content)) }),
      })
    end)
    :totable()

  return [[<?xml version="1.0" encoding="utf-8"?>]]
    .. h.render(h.el("feed", { a.attr("xmlns", "http://www.w3.org/2005/Atom") }, {
      h.el("title", {}, { h.text(config.title) }),
      h.el("subtitle", {}, { h.text "olexsmir's blog feed" }),
      h.el("id", {}, { h.text(config.home_url .. "/") }),
      h.el("link", { a.href(config.home_url), a.attr("rel", "alternate") }, {}),
      h.el("link", {
        a.href(config.feed_url),
        a.attr("rel", "self"),
        a.attr("type", "application/atom+xml"),
      }, {}),
      h.el("updated", {}, { h.text(date(posts[1].meta.date)) }),
      h.el("author", {}, {
        h.el("name", {}, { h.text(config.name) }),
        h.el("email", {}, { h.text(config.email) }),
      }),
      unpack(entries),
    }))
end

return rss
