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
  return h.el("html", { a.attr("lang", "en,uk") }, {
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
      h.el("link", {
        a.attr("rel", "shortcut icon"),
        a.attr("type", "image/svg+xml"),
        a.href "data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20100%20100'%3E%3Ctext%20y='.9em'%20font-size='90'%3E🌀%3C/text%3E%3C/svg%3E",
      }, {}),
      h.meta { a.attr("description", page_desc) },
      meta_property("og:description", page_desc),
      meta_property("og:site_name", "olexsmir's blog"),
      meta_property("og:title", page_title),
      meta_property("og:type", "website"),
      -- TODO: add twitter meta props
    }),
    h.el("body", { a.class "home" }, body),
  })
end

local function header()
  return h.el("header", {}, {
    h.a({ a.class "title", a.href "/" }, {
      h.el("h1", {}, { h.text "olexsmir's blog" }),
    }),
    h.el("nav", {}, {
      h.p({}, {
        h.a({ a.href "/" }, { h.text "home" }),
        h.a({ a.href "/posts" }, { h.text "posts" }),
        h.a({ a.href "https://github.com/olexsmir" }, { h.text "github" }),
        h.a({ a.href "/feed.xml" }, { h.text "rss" }),
      }),
    }),
  })
end

function pages.not_found()
  return with_body("Not found", "There's nothing here", {
    header(),
    h.main({}, {
      h.el("h1", {}, { h.text "There's nothing here!" }),
      h.p({}, {
        h.text "Go pack to the ",
        h.el("a", { a.href "/" }, { h.text "home page" }),
      }),
    }),
  })
end

local function list_posts(posts)
  return vim
    .iter(posts)
    :map(function(post)
      return h.li({ a.href(post.meta.slug) }, {
        h.span({}, {
          h.el("i", {}, {
            h.el("time", { a.attr("datetime", post.meta.date) }, { h.text(post.meta.date) }),
          }),
        }),
        h.a({ a.href(post.meta.slug) }, { h.text(post.meta.title) }),
      })
    end)
    :totable()
end

---@param recent_posts site.Post[]
---@return site.HtmlNote
function pages.home(recent_posts)
  return with_body("olexsmir", "A personal blog where I share my thoughts", {
    header(),
    h.main({}, {
      h.p({}, {
        h.text "Hi, and welcome to my blog.",
      }),
      h.div({}, {
        h.el("h2", {}, { h.text "Recent posts" }),
        h.ul({ a.class "blog-posts" }, list_posts(recent_posts)),
      }),
    }),
  })
end

function pages.posts(posts)
  return with_body("posts", "list of all my posts", {
    header(),
    h.main({}, {
      h.ul({ a.class "blog-posts" }, list_posts(posts)),
    }),
  })
end

---@param post site.Post
---@return site.HtmlNote
function pages.post(post)
  return with_body(post.meta.title, "", {
    header(),
    h.main({}, {
      h.el("h1", {}, { h.text(post.meta.title) }),
      h.p({}, { h.el("time", { a.attr("datetime", post.meta.date) }, { h.text(post.meta.date) }) }),
      h.raw(post.content),
    }),
  })
end

return pages
