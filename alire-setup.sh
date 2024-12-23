#!/bin/sh
PREFIX="/usr/local"
VERSION=`grep '^version' alire.toml | sed -e s,.*=,, -e 's, ,,g' -e s,\",,g `
DEBUG=False
for i in $*; do
    case $i in
        PREFIX=*|VERSION=*|DEBUG=*)
            eval $i
            ;;

    esac
done
(
    echo PREFIX:=\"${PREFIX}\"
    echo VERSION:=\"${VERSION}\"
    echo DEBUG:=${DEBUG}
) > spdx_tool-new.def
if test -f spdx_tool.def && cmp spdx_tool-new.def spdx_tool.def; then
  rm -f spdx_tool-new.def
  if test -f src/spdx_tool-configs-defaults.ads ; then
    exit 0
  fi
else
  mv spdx_tool-new.def spdx_tool.def
fi
gnatprep src/spdx_tool-configs-defaults.gpb src/spdx_tool-configs-defaults.ads spdx_tool.def

