local css = {}

---@param str string
---@return string
local function to_kebab_case(str)
  str = str:gsub("_", "-")
  str = str:gsub("([a-z])([A-Z])", "%1-%2"):lower() -- Convert camelCase to kebab-case
  return str
end

---@param value string|number
---@return string
local function value_to_css(value)
  if type(value) == "number" then
    return tostring(value)
  end
  return string.format('%s', value)
end

local function render_properties(properties)
  local parts = {}
  local keys = {}
  for key in pairs(properties) do
    table.insert(keys, key)
  end
  table.sort(keys)

  for _, key in ipairs(keys) do
    local value = properties[key]
    if type(value) == "table" then -- nested rules
      local nested_props = render_properties(value)
      table.insert(parts, string.format("%s{%s}", key, nested_props))
    else
      table.insert(parts, string.format("%s:%s", to_kebab_case(key), value_to_css(value)))
    end
  end

  return table.concat(parts, ";")
end

function css.style(rules)
  local rule_parts = {}
  local selectors = {}
  for selector in pairs(rules) do
    table.insert(selectors, selector)
  end
  table.sort(selectors)

  for _, selector in ipairs(selectors) do
    local properties = rules[selector]
    local props_str = render_properties(properties) .. ";"
    table.insert(rule_parts, string.format("%s{%s}", selector, props_str))
  end

  return table.concat(rule_parts, "")
end

return css
