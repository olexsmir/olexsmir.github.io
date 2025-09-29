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
  vim.fn.mkdir(path)
end

return file
