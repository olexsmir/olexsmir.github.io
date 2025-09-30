local t = require "spec.testutils"
local _, T, post = t.setup "post"

local p = require "site.post"

post["read fixture"] = function()
  local inp = p.read_file "./spec/fixture.md"

  t.eq(inp.meta.date, "2025-09-30")
  t.eq(inp.meta.slug, "testing")
  t.eq(inp.meta.title, "This is fixture")

  t.eq(inp.content, "<h1>Content</h1>\n<p>Here's the content.</p>")
end

post["sort_by_date"] = function()
  local input = {
    { meta = { date = "2025-09-30" } },
    { meta = { date = "2024-09-30" } },
    { meta = { date = "2025-08-30" } },
    { meta = { date = "2025-09-28" } },
    { meta = { date = "2025-06-30" } },
    { meta = { date = "2025-07-04" } },
    { meta = { date = "2025-06-21" } },
    { meta = { date = "2025-06-13" } },
    { meta = { date = "2025-06-21" } },
  }

  p.sort_by_date(input)

  t.eq(input, {
    { meta = { date = "2025-09-30" } },
    { meta = { date = "2025-09-28" } },
    { meta = { date = "2025-08-30" } },
    { meta = { date = "2025-07-04" } },
    { meta = { date = "2025-06-30" } },
    { meta = { date = "2025-06-21" } },
    { meta = { date = "2025-06-21" } },
    { meta = { date = "2025-06-13" } },
    { meta = { date = "2024-09-30" } },
  })
end

return T
