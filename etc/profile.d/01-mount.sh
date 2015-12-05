#!/bin/bash

[ -z "$MOUNT_FINISHED" ] && [ "$SHLVL" = "1" ] || return

# bind windows user-dirs to home folder
if [ ! -e "$HOME/.config/user-dirs.dirs" ]; then
    if which xdg-user-dirs-update >/dev/null 2>&1; then
        xdg-user-dirs-update --force
    fi
fi
for d in DESKTOP DOCUMENTS DOWNLOAD MUSIC PICTURES PUBLICSHARE TEMPLATES VIDEOS; do
	ud="$(xdg-user-dir $d)"
    mount | grep "\\s$ud\\s" >/dev/null && break
	upd="$(cygpath $USERPROFILE/$(basename $ud))"
    if [ ! "$(ls -A $ud)" ] && [ -e "$upd" ];  then
		mount -fo user $(cygpath -w $(readlink -f $upd)) $ud
	fi
done

MOUNT_FINISHED=1
