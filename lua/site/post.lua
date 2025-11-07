local file = require "site.file"
local frontmatter = require "site.frontmatter"
local markdown = require "site.markdown"
local post = {}

---@class site.Post
---@field content string
---@field hidden boolean
---@field meta site.PostMeta

---@class site.PostMeta
---@field title string
---@field date string
---@field slug string
---@field desc string

---@param fpath site.FilePath
---@return site.Post
function post.read_file(fpath)
  local p = file.read(fpath)
  local content = table.concat(frontmatter.content(p) or {}, "\n")
  local meta = frontmatter.extract(p)
  local hidden = meta["hidden"] == "true"
  assert(meta["title"] ~= nil, (file.to_path(fpath) .. " doesn't have title"))
  assert(meta["date"] ~= nil, (file.to_path(fpath) .. " doesn't have date"))
  assert(meta["slug"] ~= nil, (file.to_path(fpath) .. " doesn't have slug"))

  return {
    meta = meta,
    hidden = hidden,
    content = markdown(content),
  }
end

---MUTATES THE TABLE
---@param posts site.Post[]
function post.sort_by_date(posts)
  table.sort(posts, function(a, b)
    return a.meta.date > b.meta.date
  end)
end

return post
