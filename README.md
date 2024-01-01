# SPDX Tool

[![Build Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/build.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/summary)
[![Test Status](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/tests.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/xunits)
[![Coverage](https://img.shields.io/endpoint?url=https://porion.vacs.fr/porion/api/v1/projects/spdx-tool/badges/coverage.json)](https://porion.vacs.fr/porion/projects/view/spdx-tool/summary)

# TL;DR

Identify licenses used in a project:

```
spdx-tool .
License                    Count               Ratio
Apache-2.0                   468                67.3  ━━━━━━━━━━━━━━━━━━━━━━━━━
None                         194                27.9  ━━━━━━━━━━━━━━━━━━━━━━━━━
ISC                           31                 4.4  ━━━━━━━━━━━━━━━━━━━━━━━━━
BSD-3-Clause                   1                 0.1  ━━━━━━━━━━━━━━━━━━━━━━━━━
FSFUL                          1                 0.1  ━━━━━━━━━━━━━━━━━━━━━━━━━
```

Identify files matching a given license:

```
spdx-tool --only-licenses=FSFUL -f .
FSFUL                                    1
   ./configure
```

Replace the license header by the `SPDX-License-Identifier` header:

```
spdx-tool --only-licenses=Apache-2.0 --update src
```


## Version 0.1.0  - Jan 2024
  - First version to identify licenses and change to use the `SPDX-License-Identifier` header.

# Overview

# References

