local file = {}

---@param dir_path string
---@return string[]
function file.list_dir(dir_path)
  return vim.fn.readdir(dir_path)
end

---@param fpath string
---@return string[]
function file.read(fpath)
  return vim.fn.readfile(fpath)
end

---@param fpath string
---@param content string
function file.write(fpath, content)
  vim.fn.writefile({ content }, fpath)
end

---@param path string
function file.rm(path)
  vim.fs.rm(path, { force = true, recursive = true })
end

---@param path string
function file.mkdir(path)
  vim.fn.mkdir(path, "p")
end

---@param fpath string
function file.is_dir(fpath)
  local build_dir_stats = vim.uv.fs_stat(fpath)
  return not build_dir_stats or build_dir_stats.type == "directory"
end

function file.copy(from, to)
  file.mkdir(to)
  for _, f in ipairs(vim.fn.readdir(from)) do
    vim.uv.fs_copyfile(vim.fs.joinpath(from, f), vim.fs.joinpath(to, f))
  end
end

return file
