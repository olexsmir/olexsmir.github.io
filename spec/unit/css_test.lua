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

  t.eq(c.style(rules), [[body{h1{color:red};margin:0;}]])
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
        span = {
          fontWeight = "bold",
        },
      },
    },
  }

  t.eq(c.style(rules), [[.container{.inner{margin:0;span{font-weight:bold}};padding:10px;}]])
end

return T
