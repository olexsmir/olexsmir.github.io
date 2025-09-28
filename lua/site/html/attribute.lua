local hattribute = {}

---@class site.HtmlAttribute
---@field [string] string

---@param attribute string
---@param value string
---@return site.HtmlAttribute
function hattribute.attr(attribute, value)
  return { [attribute] = value }
end

-- COMMON ATTRIBUTES
-- stylua: ignore start

---@param class string
function hattribute.class(class) return hattribute.attr("class", class) end

---@param link string
function hattribute.href(link) return hattribute.attr("href", link) end

-- stylua: ignore end

return hattribute
