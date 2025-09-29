local t = require "spec.testutils"
local _, T, css = t.setup "css"

local c = require "site.css"

css["simple css"] = function()
  local rules = {
    body = {
      margin = 0,
      ["font-family"] = "sans-serif",
    },
  }

  t.eq(c.style(rules), [[body{font-family:sans-serif;margin:0;}]])
end

css["nested-styles"] = function()
  local rules = {
    body = {
      margin = 0,
      h1 = {
        color = "red",
      },
    },
  }

  t.eq(c.style(rules), [[body{margin:0;}body h1{color:red;}]])
end

css["camelCase properties"] = function()
  local rules = {
    [".button"] = {
      backgroundColor = "blue",
      fontSize = "14px",
    },
  }

  t.eq(c.style(rules), [[.button{background-color:blue;font-size:14px;}]])
end

css["multiple selectors"] = function()
  local rules = {
    body = { margin = 0 },
    h1 = { color = "black" },
  }

  t.eq(c.style(rules), [[body{margin:0;}h1{color:black;}]])
end

css["deep nesting"] = function()
  local rules = {
    [".container"] = {
      padding = "10px",
      [".inner"] = {
        margin = 0,
        span = { fontWeight = "bold", },
        ["&:hover"] = { color = "blue", },
      },
    },
  }

  t.eq(
    c.style(rules),
    [[.container{padding:10px;}.container .inner{margin:0;}.container .inner span{font-weight:bold;}.container .inner:hover{color:blue;}]]
  )
end

css["@media"] = function()
  local rules = {
    ["@media screen and (min-width: 1200px)"] = {
      margin = 0,
    },
  }
  t.eq(c.style(rules), [[@media screen and (min-width: 1200px){margin:0;}]])
end

css[":root"] = function()
  local rules = {
    [":root"] = {
      ["--h1-size"] = "3rem",
    },
  }
  t.eq(c.style(rules), [[:root{--h1-size:3rem;}]])
end

return T
