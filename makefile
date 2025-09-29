.SILENT:
.PHONY:

CMD=nvim --clean --headless -u ./minit.lua

test:
	$(CMD) -c "lua MiniTest.run()"

build:
	nvim --clean -u ./minit.lua -l build.lua
