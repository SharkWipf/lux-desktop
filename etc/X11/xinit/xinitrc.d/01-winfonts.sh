#!/bin/bash

winsys="$(cygpath "${SYSTEMROOT}/Fonts")"
if [ -e "$winsys" ]; then
    mount -fo user $(cygpath -w $winsys) /usr/share/fonts/winsys
    fc-cache -s
fi
