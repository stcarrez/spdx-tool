# SPDX Tool

[![Build Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/build.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/summary)
[![Test Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/tests.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/xunits)
[![Coverage](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/coverage.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/summary)

# TL;DR

## Identify licenses used in a project

```
spdx-tool .
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

Likewise but keep the first line two lines of the existing license header:

```
spdx-tool --only-licenses=Apache-2.0 --update=1..2.spdx src
```

## Build an XML or JSON report of files with their licenses

```
spdx-tool --output-xml=report.xml .
spdx-tool --output-json=report.json .
```

## Version 0.2.0  - May 2024
  - License identification improvement
  - Update replacement of `SPDX-License-Identifier` and allow keeping some lines from original license header

## Version 0.1.0  - Jan 2024
  - First version to identify licenses and change to use the `SPDX-License-Identifier` header.

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
  * guess the best matching license by computing the [Tversky](https://en.wikipedia.org/wiki/Tversky_index)
    index (0..1) and reporting the repository license having the highest Tversky index.  The report will
    indicate the highest Tversky index found.


# References

* https://github.com/spdx/license-list-data
* https://spdx.org
* https://spdx.dev/learn/handling-license-info/
* https://github.com/github-linguist/linguist.git

