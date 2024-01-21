BUILD=#coverage
MAKE_ARGS=

ifeq ($(BUILD),coverage)
MAKE_ARGS=-- -XBUILD=coverage
endif

ifeq ($(BUILD),debug)
MAKE_ARGS=-- -XBUILD=debug
endif

PREFIX=/usr/local

build:
	alr build $(MAKE_ARGS)
	cd tools && alr build $(MAKE_ARGS)

build-tests:
	cd regtests && alr build $(MAKE_ARGS)

generate:
	cd tools && alr build $(MAKE_ARGS)
	bin/genlangmap tools/languages.json > tools/extensions.json
	are --rule=are-package.xml -o src/generated --content-only --no-type-declaration --name-access --list-access .
	cd tools && alr build $(MAKE_ARGS)
	bin/gendecisiontree > src/generated/spdx_tool-licenses-decisions.ads

test: build-tests
	bin/spdx_tool-harness

clean:
	alr clean
	rm -rf obj bin lib

install:
	alr exec gprinstall -- -p --mode=usage --prefix=${PREFIX} -q -Pspdx_tool.gpr
