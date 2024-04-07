BUILD=#coverage
MAKE_ARGS=
JSON_PP=json_pp

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

JSON_SRC=tools/languages.json tools/languages-addon.json

generate:
	cd tools && alr build $(MAKE_ARGS)
	bin/spdx_tool-genmap --extensions $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/extensions.json
	bin/spdx_tool-genmap --filenames $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/filenames.json
	bin/spdx_tool-genmap --interpreters $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/interpreters.json
	bin/spdx_tool-genmap --mimes $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/mimes.json
	bin/spdx_tool-genmap --aliases $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/aliases.json
	bin/spdx_tool-genmap --comments $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/comments.json
	are --rule=are-package.xml -o src/generated .
	cd tools && alr build $(MAKE_ARGS)
	bin/gendecisiontree > src/generated/spdx_tool-licenses-decisions.ads

test: build-tests
	bin/spdx_tool-harness -v

clean:
	alr clean
	rm -rf obj bin lib

install:
	alr exec gprinstall -- -p --mode=usage --prefix=${PREFIX} -q -Pspdx_tool.gpr
