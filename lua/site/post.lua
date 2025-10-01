local file = require "site.file"
local frontmatter = require "site.frontmatter"
local markdown = require "site.markdown"
local post = {}

---@class site.PostMeta
---@field title string
---@field date string
---@field slug string
---@field desc string

---@class site.Post
---@field content string
---@field meta site.PostMeta

---@param fpath string
---@return site.Post
function post.read_file(fpath)
  local p = file.read(fpath)
  local content = table.concat(frontmatter.content(p) or {}, "\n")
  local meta = frontmatter.extract(p)
  assert(meta["title"] ~= nil, (fpath .. " doesn't have title"))
  assert(meta["date"] ~= nil, (fpath .. " doesn't have date"))
  assert(meta["slug"] ~= nil, (fpath .. " doesn't have slug"))
  assert(meta["desc"] ~= nil, (fpath .. " doesn't have description"))

  return { meta = meta, content = markdown(content) }
end

-- MUTATES THE TABLE
---@param posts site.Post[]
function post.sort_by_date(posts)
  table.sort(posts, function(a, b)
    return a.meta.date > b.meta.date
  end)
end

return post
