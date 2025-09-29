local t = require "spec.testutils"
local _, T, frontmatter = t.setup "frontmatter"

local f = require "site.frontmatter"

frontmatter["should extract from frontmatter"] = function()
  local input = {
    "---",
    "title=The title",
    "link=test",
    "---",
    "the content is here",
  }

  t.eq(f.extract(input), {
    title = "The title",
    link = "test",
  })
end

frontmatter["support options with spaces"] = function()
  local input = {
    "---",
    "title = The title",
    "link one = some long thing here",
    "---",
    "the content is here",
  }

  t.eq(f.extract(input), {
    title = "The title",
    ["link one"] = "some long thing here",
  })
end

frontmatter["should return nil if there's no frontmatter"] = function()
  local input = {
    "there's no frontmatter",
    "just text",
  }

  t.eq(f.extract(input), nil)
end

frontmatter["should return empty list if frontmatter is empty"] = function()
  local input = {
    "---",
    "---",
    "there's no frontmatter",
    "just text",
  }

  t.eq(f.extract(input), {})
end

return T
