local file = require "site.file"
local frontmatter = require "site.frontmatter"
local post = {}

---@class site.Post
---@field content site.HtmlNote
---@field meta table<string, string>

---@param fpath string
---@return site.Post
function post.read_file(fpath)
  local p = file.read(fpath)
  return {
    meta = frontmatter.extract(p),
    content = frontmatter.content(p),
  }
end

-- MUTATES THE TABLE
---@param posts site.Post[]
function post.sort_by_date(posts)
  table.sort(posts, function(a, b)
    return a.meta.date > b.meta.date
  end)
end

return post
