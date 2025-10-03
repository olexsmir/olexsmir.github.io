local file = {}

---@alias site.FilePath string|string[]

---@param p site.FilePath
---@return string
function file.to_path(p)
  if type(p) == "table" then
    return vim.fs.joinpath(unpack(p))
  end
  return p
end

---@param path site.FilePath
---@return string[]
function file.list_dir(path)
  return vim.fn.readdir(file.to_path(path))
end

---@param path site.FilePath
function file.read(path)
  return vim.fn.readfile(file.to_path(path))
end

---@param path site.FilePath
---@param content string
function file.write(path, content)
  vim.fn.writefile(vim.split(content, "\n", { plain = true }), file.to_path(path))
end

---@param path site.FilePath
function file.rm(path)
  vim.fs.rm(file.to_path(path), { force = true, recursive = true })
end

---@param path string
function file.mkdir(path)
  vim.fn.mkdir(file.to_path(path), "p")
end

---@param path string
function file.is_dir(path)
  local build_dir_stats = vim.uv.fs_stat(file.to_path(path))
  return not build_dir_stats or build_dir_stats.type == "directory"
end

---@param from string
---@param to string
function file.copy_dir(from, to)
  file.mkdir(file.to_path(to))
  for _, f in ipairs(vim.fn.readdir(from)) do
    vim.uv.fs_copyfile(vim.fs.joinpath(from, f), vim.fs.joinpath(to, f))
  end
end

return file
