# SPDX Tool

[![Build Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/build.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/summary)
[![Test Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/tests.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/xunits)
[![Coverage](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/coverage.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/summary)

# TL;DR

## Identify licenses used in a project

```
spdx-tool
License               Match          Count          Ratio
Apache-2.0             TMPL             62           60.1
None                                    34           33.0
GPL-3.0-or-later       0.81              3            2.9
GPL-2.0-or-later       0.86              2            1.9
FSFUL                  TMPL              1            0.9
NTP                    0.74              1            0.9
```

## Identify files matching a given license

```
spdx-tool --only-licenses=FSFUL,NTP -f .
FSFUL                                    1
   configure
NTP                                      1
   install-sh
```

## Check the license header before replacing it

```
spdx-tool --only-licenses=Apache-2.0 --print-license --line-number src
```

## Replace the license header by the `SPDX-License-Identifier` header

```
spdx-tool --only-licenses=Apache-2.0 --update=spdx src
```

Likewise but keep the first two lines of the existing license header:

```
spdx-tool --only-licenses=Apache-2.0 --update=1..2.spdx src
```

## Build an XML or JSON report of files with their licenses

```
spdx-tool --output-xml=report.xml .
spdx-tool --output-json=report.json .
```

## Version 0.4.1  - Dec 2024
  - Fix compilation on FreeBSD and Windows

[List all versions](https://gitlab.com/stcarrez/spdx-tool/blob/master/NEWS.md)

# Overview

spdx-tool scans the source files to identify licenses and allows to update them in order to use the
SPDX license format.  It can be used to:

* identify the license used in source files of a project,
* produce a JSON/XML report for the licenses found with the list of files,
* replace a license header by the [SPDX license](https://spdx.org/licenses/) tag equivalent.

The tool uses the [license templates](https://github.com/spdx/license-list-data) to identify
the license used in source files.  The builtin repository contains arround 600 license templates
and it can be completed by your own templates as long as you use the SPDX license description
format described in [The Software Package Data Exchange® (SPDX®) Specification Version 2.3](https://spdx.github.io/spdx-spec/v2.3/).

The spdx-tool scans the directory or files passed as parameter.  Directories are scanned recursively
and the `.gitignore` file is first looked in each directory to take into account files which are ignored
in the project.  For each file, the spdx-tool tries to:

* identify the language of the source file,
* extract the license header text at beginning of the source file,
* identify the license by using the following algorithms:
  * look for a `SPDX-License-Identifier` tag, when it was found, the match report indicates `SPDX`,
  * look for a template match from the [license templates](https://github.com/spdx/license-list-data)
    builtin repository or the templates configured for the tool.  When this succeeds, the match
    report indicates `TMPL`,
  * last, we guess the best matching license by using an inverted index of license tokens.
    The tool then uses a classical *term frequency inverse document frequency*
    algorithm to find the best matching license.  The report will indicate the
    highest [Cosine similarity](https://en.wikipedia.org/wiki/Cosine_similarity) found.

# Documentation

* Man page: [spdx-tool (1)](https://gitlab.com/stcarrez/spdx-tool/-/blob/main/docs/spdx-tool.md?ref_type=heads)

# Debian Packages for x86_64

You can install spdx-tool by using the Debian 12 and Ubuntu 24.04 packages.
First, setup to accept the signed packages:

```
wget -O - https://apt.vacs.fr/apt.vacs.fr.gpg.asc | sudo tee /etc/apt/trusted.gpg.d/apt-vacs-fr.asc
```

and choose one of the `echo` command according to your Linux distribution:

Ubuntu 24.04
```
echo "deb https://apt.vacs.fr/ubuntu-noble noble main" | sudo tee -a /etc/apt/sources.list.d/vacs.list
```

Debian 12
```
echo "deb https://apt.vacs.fr/debian-bullseye bullseye main" | sudo tee -a /etc/apt/sources.list.d/vacs.list
```

Then, launch the apt update command:

```
sudo apt-get update
```

and install the tool using:

```
sudo apt-get install -y spdx-tool
```

# Build

To build the spdx-tool you will need the GNAT Ada compiler as well
as the [Alire](https://alire.ada.dev/) package manager.

```
make
```

# Improving the tool

## Adding new languages

New languages can be easily added by editing the `tools/languages-addon.json` file
and declaring the language with the corresponding file extensions and the comment
type that must be used to parse the header and extract the license.  A typical
configuration looks like:

```
"GNAT Project": {
   "type": "programming",
   "extensions": [
      ".gpr"
   ],
   "comment_style": "dash-style"
},
```

After updating the `tools/languages-addon.json` file, rebuild the generated Ada
files by running:

```
make generate
```

## Fixing language comment style

When a language is recognized but the analyser does not know how to extract
comments, it can be fixed by adding a definition in `tools/languages-addon.json` file:

```
"Dart": {
   "comment_style": "C-style"
},
```

Recognized comment styles include:

```
"dash-style", "--"
"C-line", "//"
"Shell", "#"
"Latex-style", "%"
"Forth", "\"
"C-block", "/*", "*/"
"XML", "<!--", "-->"
"OCaml-style", "(*", "*)"
"Erlang-style", "%%"
"Semicolon", ";"
"JSP-style", "<%--", "--%>"
"Smarty-style", "{*", "*}"
"Haskell-style", "{-", "-}"
"Smalltalk-style", """", """"
"PowerShell-block", "<#", "#>"
"CoffeeScript-block", "###", "###"
"PowerShell-style", "", "", "PowerShell-block,Shell"
"CoffeeScript-style", "", "", "Shell,CoffeeScript-block"
"C-style", "", "", "C-line,C-block"
```

# References

* https://github.com/spdx/license-list-data
* https://spdx.org
* https://spdx.dev/learn/handling-license-info/
* https://github.com/github-linguist/linguist.git

