#!/bin/sh
[ -n "$FIFO_UEBERZUG" ] &&
    printf '{"action": "remove", "identifier": "preview"}\n' >"$FIFO_UEBERZUG"

[ -n "$(which kitty 2>/dev/null)" ] &&
    kitty +icat --clear --silent --transfer-mode file
