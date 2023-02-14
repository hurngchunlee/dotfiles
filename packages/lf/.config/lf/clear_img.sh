#!/bin/sh
[ -n "$FIFO_UEBERZUG" ] &&
    printf '{"action": "remove", "identifier": "preview"}\n' >"$FIFO_UEBERZUG"

## Notice the kitty's breaking change: https://github.com/gokcehan/lf/issues/1099
[ -n "$(which kitty 2>/dev/null)" ] &&
    kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
