#!/bin/bash

[ -n "$MOUNT_FINISHED" ] && return

# bind windows user-dirs to home folder
if which xdg-user-dirs-update >/dev/null 2>&1; then
    xdg-user-dirs-update --force
fi
for d in DESKTOP DOCUMENTS DOWNLOAD MUSIC PICTURES PUBLICSHARE TEMPLATES VIDEOS; do
	ud="$(xdg-user-dir $d)"
	upd="$(cygpath $USERPROFILE/$(basename $ud))"
	if [ -e "$upd" ] && ! find "$ud" -mindepth 1 -print -quit 2>/dev/null | grep -q . ; then
		mount -fo user $(cygpath -w $(readlink -f $upd)) $ud
	fi
done

MOUNT_FINISHED=1
