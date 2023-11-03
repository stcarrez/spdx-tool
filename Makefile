build:
	alr build

generate:
	are --rule=are-package.xml -o src --content-only --name-access --list-access .

test: build
	bin/spdx_tool-harness
