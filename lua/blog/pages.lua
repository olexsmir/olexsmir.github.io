local a = require "site.html.attribute"
local h = require "site.html"
local c = require "blog.config"
local pages = {}

---@param page_title string
---@param body site.HtmlNote[]
local function with_body(page_title, body)
  return h.el("html", { a.attr("lang", "en") }, {
    h.el("head", {}, {
      h.title({}, { h.text(page_title) }),
      h.meta { a.attr("charset", "utf-8") },
      h.meta {
        a.attr("name", "viewport"),
        a.attr("content", "width=device-width, initial-scale=1.0, viewport-fit=cover"),
      },
      h.link {
        a.attr("rel", "alternate"),
        a.attr("type", "application/atom+xml"),
        a.attr("title", c.feed.subtitle),
        a.href(c.feed.url),
      },
      h.link {
        a.attr("rel", "stylesheet"),
        a.href "style.css",
      },
      h.link {
        a.attr("rel", "shortcut icon"),
        a.attr("type", "image/svg+xml"),
        a.href "data:image/svg+xml,%3Csvg%20xmlns='http://www.w3.org/2000/svg'%20viewBox='0%200%20100%20100'%3E%3Ctext%20y='.9em'%20font-size='90'%3E🌀%3C/text%3E%3C/svg%3E",
      },
      -- h.meta { a.attr("name", "description"), a.attr("content", page_desc) },
      -- h.meta { a.attr("property", "og:description"), a.attr("content", page_desc) },
      h.meta { a.attr("property", "og:site_name"), a.attr("content", page_title) },
      h.meta { a.attr("property", "og:title"), a.attr("content", page_title) },
      h.meta { a.attr("property", "og:type"), a.attr("content", "website") },
      -- TODO: add twitter meta props
    }),
    h.el("body", { a.class "home" }, body),
  })
end

local function header()
  return h.el("header", {}, {
    h.nav({}, {
      h.p({}, {
        h.a({ a.href "/" }, { h.text "home" }),
        h.a({ a.href "/posts" }, { h.text "posts" }),
        h.a({ a.href "https://github.com/olexsmir" }, { h.text "github" }),
        h.a({ a.href "/feed.xml" }, { h.text "rss" }),
      }),
    }),
    h.a({ a.class "title", a.href "/" }, {
      h.h1({}, { h.text(c.title) }),
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

---@return site.HtmlNote
function pages.home()
  return with_body("olexsmir", {
    header(),
    h.main({}, {
      h.p({}, { h.text "Hi, and welcome to my blog." }),
    }),
  })
end

function pages.posts(posts)
  return with_body("posts", {
    header(),
    h.main({}, {
      h.ul({ a.class "blog-posts" }, list_posts(posts)),
    }),
  })
end

---@param post site.Post
---@return site.HtmlNote
function pages.post(post)
  return with_body(post.meta.title, {
    header(),
    h.main({}, {
      h.h1({}, { h.text(post.meta.title) }),
      h.p({}, {
        h.el("time", { a.attr("datetime", post.meta.date) }, { h.text(post.meta.date) }),
      }),
      h.raw(post.content),
    }),
  })
end

function pages.not_found()
  return with_body("Not found", {
    header(),
    h.main({}, {
      h.h1({}, { h.text "There's nothing here!" }),
      h.p({}, {
        h.text "Go pack to the ",
        h.a({ a.href "/" }, { h.text "home page" }),
      }),
    }),
  })
end

return pages
