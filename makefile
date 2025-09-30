.PHONY: all build test

CMD=nvim --clean -u ./scripts/minit.lua

test:
	$(CMD) --headless -c "lua MiniTest.run()"

build:
	$(CMD) -l ./scripts/build.lua
