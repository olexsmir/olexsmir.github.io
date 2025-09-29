.SILENT:
.PHONY:

CMD=nvim --clean --headless -u ./minit.lua

test:
	$(CMD) -c "lua MiniTest.run()"

build:
	$(CMD) -c "lua require'blog'.build()" -l

nvim:
	nvim --clean -u ./minit.lua
