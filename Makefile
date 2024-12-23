MAKE_ARGS=
JSON_PP=json_pp
VERSION=0.4.1
DEBUG_MODE=True
INSTALL=install

-include Makefile.conf

MAKE_ARGS=-XSPDX_TOOL_BUILD=$(BUILD)
BUILD?=distrib
PREFIX?=/usr/local
ALR?=alr --non-interactive
BUILD_COMMAND?=$(ALR) build --

build: src/spdx_tool-configs-defaults.ads
	$(BUILD_COMMAND) $(MAKE_ARGS)

build-tests:
	cd regtests && $(BUILD_COMMAND) $(MAKE_ARGS)

JSON_SRC=tools/languages.json tools/languages-addon.json

generate:
	cd tools && $(BUILD_COMMAND) $(MAKE_ARGS)
	bin/spdx_tool-genmap --extensions $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/extensions.json
	bin/spdx_tool-genmap --filenames $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/filenames.json
	bin/spdx_tool-genmap --interpreters $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/interpreters.json
	bin/spdx_tool-genmap --mimes $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/mimes.json
	bin/spdx_tool-genmap --aliases $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/aliases.json
	bin/spdx_tool-genmap --comments $(JSON_SRC) | $(JSON_PP) > share/spdx-tool/comments.json
	bin/spdx_tool-gentmpl src/generated/spdx_tool-licenses-templates.ads
	bin/spdx_tool-genrules src/generated/spdx_tool-languages-rules-generated.ads tools/generated.json
	bin/spdx_tool-genrules src/generated/spdx_tool-languages-rules-disambiguations.ads tools/disambiguations.json
	cd tools && alr exec are -- --rule=../are-package.xml -o ../src/generated ..

import-licenses:
	cd tools && $(BUILD_COMMAND) $(MAKE_ARGS)
	bin/spdx_tool-genlicenses jsonld licenses/standard licenses/exceptions

test: build-tests
	bin/spdx_tool-harness -v -xml spdx_tool-aunit.xml

clean:
	alr clean
	rm -rf obj bin lib

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	$(INSTALL) bin/spdx-tool $(DESTDIR)$(PREFIX)/bin/spdx-tool
	mkdir -p $(DESTDIR)$(PREFIX)/share/man/man1
	$(INSTALL) man/man1/spdx-tool.1 $(DESTDIR)$(PREFIX)/share/man/man1/spdx-tool.1
	(cd share && tar --exclude='*~' -cf - .) \
         | (cd $(DESTDIR)$(PREFIX)/share/ && tar xf -)
	mkdir -p $(DESTDIR)$(PREFIX)/share/locale/fr/LC_MESSAGES
	$(INSTALL) po/locale/fr/LC_MESSAGES/spdx-tool.mo $(DESTDIR)$(PREFIX)/share/locale/fr/LC_MESSAGES/spdx-tool.mo

# Create the .mo file from the translation file.
pot:
	msgfmt -o po/locale/fr/LC_MESSAGES/spdx-tool.mo po/fr.po

src/spdx_tool-configs-defaults.ads:   Makefile src/spdx_tool-configs-defaults.gpb
	$(ALR) exec -- sh ./alire-setup.sh PREFIX='"${PREFIX}"' VERSION='"$(VERSION)"' DEBUG='$(DEBUG_MODE)'

setup::
	echo "BUILD=$(BUILD)" > Makefile.conf
	echo "PREFIX=$(PREFIX)" >> Makefile.conf
