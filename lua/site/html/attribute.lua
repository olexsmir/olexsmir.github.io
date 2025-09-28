local attribute = {}

---@alias site.HtmlAttribute table<string, string>

---@param attr string
---@param value string|number
---@return site.HtmlAttribute
function attribute.attr(attr, value)
  return { [attr] = value }
end

-- COMMON ATTRIBUTES

-- stylua: ignore start
---@param class string
---@return site.HtmlAttribute
function attribute.class(class) return attribute.attr("class", class) end
-- stylua: ignore end

return attribute
