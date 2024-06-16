BUILD=#coverage
MAKE_ARGS=
JSON_PP=json_pp
VERSION=0.3.0
DEBUG_MODE=False
INSTALL=install

-include .env.local

ifeq ($(BUILD),coverage)
MAKE_ARGS=-- -XBUILD=coverage
endif

ifeq ($(BUILD),debug)
MAKE_ARGS=-- -XBUILD=debug
endif

PREFIX?=/usr/local

build: src/spdx_tool-configs-defaults.ads
	alr build $(MAKE_ARGS)

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
	bin/spdx_tool-gentmpl src/generated/spdx_tool-licenses-templates.ads
	bin/spdx_tool-genrules src/generated/spdx_tool-languages-rules-generated.ads tools/generated.json
	bin/spdx_tool-genrules src/generated/spdx_tool-languages-rules-disambiguations.ads tools/disambiguations.json
	are --rule=are-package.xml -o src/generated .
	# cd tools && alr build $(MAKE_ARGS)
	# bin/gendecisiontree > src/generated/spdx_tool-licenses-decisions.ads

import-licenses:
	cd tools && alr build $(MAKE_ARGS)
	bin/spdx_tool-genlicenses jsonld licenses/standard

test: build-tests
	bin/spdx_tool-harness -v

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
	gnatprep -DPREFIX='"${PREFIX}"' -DVERSION='"$(VERSION)"' -DDEBUG='$(DEBUG_MODE)'\
		  src/spdx_tool-configs-defaults.gpb src/spdx_tool-configs-defaults.ads
