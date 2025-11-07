local a = require "site.html.attribute"
local h = require "site.html"
local c = require "blog.config"
local pages = {}

local function themeSwitcherScript()
  local s = [[
    const root = document.documentElement;
    root.dataset.theme = localStorage.theme || 'light';
    document.getElementById('theme-toggle').onclick = () => {
      root.dataset.theme = root.dataset.theme === 'dark' ? 'light' : 'dark';
      localStorage.theme = root.dataset.theme;
    };
  ]]

  s = s:gsub("  ", "")
  s = vim.split(s, "\n") ---@diagnostic disable-line: cast-local-type
  s = table.concat(s, "")

  return h.el("script", {}, { h.text(s) })
end

---@param o {title:string, desc:string, has_code:boolean, body:site.HtmlNote[]}
---@return site.HtmlNote
local function with_body(o)
  return h.el("html", { a.attr("lang", "en") }, {
    h.el("head", {}, {
      h.title({}, { h.text(o.title) }),
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
      h.link { a.attr("rel", "stylesheet"), a.href "style.css" },
      o.has_code and h.link { a.attr("rel", "stylesheet"), a.href "chroma.css" } or {},
      h.link { a.attr("rel", "icon"), a.href "assets/favicon.svg" },
      h.meta { a.attr("name", "description"), a.attr("content", o.desc) },
      h.meta { a.attr("property", "og:description"), a.attr("content", o.desc) },
      h.meta { a.attr("property", "og:site_name"), a.attr("content", o.title) },
      h.meta { a.attr("property", "og:title"), a.attr("content", o.title) },
      h.meta { a.attr("property", "og:type"), a.attr("content", "website") },
    }),
    h.el("body", { a.class "home" }, {
      h.el("header", {}, {
        h.nav({}, {
          h.p({}, {
            h.a({ a.href "/" }, { h.text "home" }),
            h.a({ a.href "/posts" }, { h.text "posts" }),
            h.a({ a.href "https://github.com/olexsmir" }, { h.text "github" }),
            h.a({ a.href "/feed.xml" }, { h.text "feed" }),
            h.el("button", { a.id "theme-toggle" }, { h.text "🌓" }),
          }),
        }),
        h.a({ a.class "title", a.href "/" }, {
          h.h1({}, { h.text(c.title) }),
        }),
      }),
      o.body,
      themeSwitcherScript(),
    }),
  })
end

function pages.home()
  return with_body {
    title = c.title,
    desc = c.title,
    body = h.main({}, {
      h.p({}, {
        h.text "Hi, and welcome to my blog.",
        h.br(),
        h.text "I'm a gopher from Ukraine 🇺🇦, still don't know how to exit from vim.",
        h.br(),
        h.br(),
        h.text "If you want to reach me, all contacts can be found on github.",
      }),
    }),
  }
end

function pages.not_found()
  return with_body {
    title = "Not found",
    desc = "Page you're looking for, not found",
    body = h.main({}, {
      h.h1({}, { h.text "There's nothing here!" }),
      h.p({}, {
        h.text "Go pack to the ",
        h.a({ a.href "/" }, { h.text "home page" }),
      }),
    }),
  }
end

---@param posts site.Post[]
function pages.posts(posts)
  return with_body {
    title = "All olexsmir's posts",
    desc = "List of all blog posts on the site.",
    body = h.main({}, {
      h.p({}, { h.text "It ain't much, but it's honest work." }),
      h.ul(
        { a.class "blog-posts" },
        vim
          .iter(posts)
          :filter(function(post)
            return not post.hidden
          end)
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
      ),
    }),
  }
end

---@param post site.Post
function pages.post(post)
  local has_code = post.content:match "code" ~= nil
  return with_body {
    title = post.meta.title,
    desc = "Blog post titled: " .. post.meta.title,
    has_code = has_code,
    body = h.main({}, {
      h.div({ a.class "blog-title" }, {
        h.h1({}, { h.text(post.meta.title) }),
        h.p({}, {
          h.el("time", { a.attr("datetime", post.meta.date) }, { h.text(post.meta.date) }),
        }),
      }),
      h.raw(post.content),
    }),
  }
end

return pages
