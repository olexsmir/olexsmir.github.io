local function root(p)
  local f = debug.getinfo(1, "S").source:sub(2)
  return vim.fn.fnamemodify(f, ":p:h") .. "/" .. (p or "")
end

local function install_plug(plugin)
  local name = plugin:match ".*/(.*)"
  local package_root = root ".tests/site/pack/deps/start/"
  if not vim.uv.fs_stat(package_root .. name) then
    print("Installing " .. plugin)
    vim
      .system({
        "git",
        "clone",
        "--depth=1",
        "https://github.com/" .. plugin .. ".git",
        package_root .. "/" .. name,
      })
      :wait()
  end
end

install_plug "echasnovski/mini.test"

vim.env.XDG_CONFIG_HOME = root ".tests/config"
vim.env.XDG_DATA_HOME = root ".tests/data"
vim.env.XDG_STATE_HOME = root ".tests/state"
vim.env.XDG_CACHE_HOME = root ".tests/cache"

vim.opt.runtimepath:append(root())
vim.opt.packpath:append(root ".tests/site")

require("mini.test").setup {
  collect = {
    find_files = function()
      return vim.fn.globpath("spec", "**/*_test.lua", true, true)
    end,
  },
}
