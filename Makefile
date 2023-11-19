BUILD=debug
MAKE_ARGS=-- -XBUILD=$(BUILD)

build:
	alr build $(MAKE_ARGS)

generate:
	are --rule=are-package.xml -o src --content-only --name-access --list-access .

test: build
	bin/spdx_tool-harness

clean:
	alr clean
	rm -rf obj bin lib
