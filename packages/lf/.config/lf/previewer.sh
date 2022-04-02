#!/bin/sh
draw() {
    [ -n "$FIFO_UEBERZUG" ] && ~/.config/lf/draw_ueberzurg.sh "$@"
    [ -n "$(which kitty 2>/dev/null)" ] && ~/.config/lf/draw_kitty.sh "$@"
    exit 1
}

hash() {
    printf '%s/.cache/lf/%s' "$HOME" \
      "$(stat --printf '%n\0%i\0%F\0%s\0%W\0%Y' -- "$(readlink -f "$1")" | sha256sum | awk '{print $1}')"
}

cache() {
    [ -f "$1" ] && draw "$@"
}

file="$1"
shift
 
## file mime type
ftype=$(file -Lb --mime-type "$file")

case "$ftype" in
    application/x-tar)
        tar tf "$file"
	;;
    application/gzip)
        gunzip -l "$file"
	;;
    application/zip)
        unzip -l "$file"
	;;
    application/x-7z-compressed)
        7z l "$file"
        ;;
    application/pdf)
        h="$(hash "$file")"
        cache="${h}.jpg"
        cache "$cache" "$@"
        pdftoppm -jpeg -singlefile "$file" "$h"
        draw "$cache" "$@"
        ;;
    image/*)
        orientation="$(identify -format '%[EXIF:Orientation]\n' -- "$file")"
        if [ -n "$orientation" ] && [ "$orientation" != 1 ]; then
            cache="$(hash "$file").jpg"
            cache "$cache" "$@"
            convert -- "$file" -auto-orient "$cache"
            draw "$cache" "$@"
        else
            draw "$file" "$@"
        fi
        ;;
    video/*)
        cache="$(hash "$file").jpg"
        cache "$cache" "$@"
        ffmpegthumbnailer -i "$file" -o "$cache" -s 0
        draw "$cache" "$@"
        ;;
    text/html)
	[ -n "$(which w3m 2>/dev/null)" ] && w3m -dump "$file" || highlight -O ansi "$file"
        ;;
    text/*)
        highlight -O ansi "$file"
	;;
esac

file -Lb -- "$1" | fold -s -w "$width"
exit 0
