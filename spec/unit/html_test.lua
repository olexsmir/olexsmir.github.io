local t = require "spec.testutils"
local _, T, html = t.setup "html"

local h = require "site.html"
local a = require "site.html.attribute"

html["simple html"] = function()
  local node = h.el("div", {}, { h.text "hello" })

  t.eq(h.render(node), "<div>hello</div>")
end

html["simple html with attrs"] = function()
  local node = h.div({ a.attr("class", "some classes") }, { h.text "string" })
  t.eq(h.render(node), [[<div class="some classes">string</div>]])
end

html["self-closing tag"] = function()
  local node = h.el(
    "img",
    { a.attr("src", "image.png"), a.attr("alt", "Alt text") },
    {}
  )
  t.eq(h.render(node), [[<img alt="Alt text" src="image.png" />]])
end

html["nested html"] = function()
  local node = h.div({ a.class "container" }, {
    h.el("h1", {}, { h.text "Title" }),
    h.p({}, { h.text "Paragraph" }),
  })

  t.eq(
    h.render(node),
    [[<div class="container"><h1>Title</h1><p>Paragraph</p></div>]]
  )
end

html["even more nested html"] = function()
  local node = h.div({ a.class "container" }, {
    h.el("h1", {}, { h.text "Title" }),
    h.div({}, {
      h.p({}, {
        h.text "text",
        h.a({ a.href "google.com" }, { h.text "google" }),
      }),
    }),
  })

  t.eq(
    h.render(node),
    [[<div class="container"><h1>Title</h1><div><p>text<a href="google.com">google</a></p></div></div>]]
  )
end

return T
