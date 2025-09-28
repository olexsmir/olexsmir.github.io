local html = {}

---@class site.HtmlNote
---@field text? string
---@field tag? string
---@field attributes? table<string, string>
---@field children? site.HtmlNote[]

---@param tag string
---@param attributes site.HtmlAttribute[]
---@param children site.HtmlNote[]
---@return site.HtmlNote
function html.el(tag, attributes, children)
  local attrs = {}
  for _, attr_table in ipairs(attributes or {}) do
    for k, v in pairs(attr_table) do
      attrs[k] = v
    end
  end

  return {
    tag = tag,
    attributes = attrs,
    children = children or {},
  }
end

---@param text string
---@return site.HtmlNote
function html.text(text)
  return { text = text }
end

local _self_closing_tags = {
  img = {},
  br = {},
  hr = {},
  input = {},
  meta = {},
  link = {},
}

---@param node site.HtmlNote
---@return string
function html.render(node)
  if node.text then
    return node.text
  elseif node.tag then
    local attrs_str = ""
    local keys = {}
    for k in pairs(node.attributes or {}) do
      table.insert(keys, k)
    end
    table.sort(keys)
    for _, k in ipairs(keys) do
      attrs_str = attrs_str .. string.format(' %s="%s"', k, node.attributes[k])
    end

    if _self_closing_tags[node.tag] then
      return string.format("<%s%s />", node.tag, attrs_str)
    end

    local children_str = ""
    for _, child in ipairs(node.children or {}) do
      children_str = children_str .. html.render(child)
    end
    return string.format(
      "<%s%s>%s</%s>",
      node.tag,
      attrs_str,
      children_str,
      node.tag
    )
  end

  return ""
end

return html
