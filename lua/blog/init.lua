local post = require "site.post"
local file = require "site.file"
local blog = {}

local config = {
  output_dir = "build",
  posts_dir = "posts",
  assets_dir = "assets",
}

function blog.build()
  local posts = vim
    .iter(file.list_dir(config.posts_dir))
    :map(function(fname)
      return post.read_file(config.posts_dir .. "/" .. fname)
    end)
    :totable()

  post.sort_by_date(posts)

  vim.print(posts)
end

return blog
