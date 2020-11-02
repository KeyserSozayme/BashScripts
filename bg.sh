#! /usr/bin/env bash

WP_Left="/home/keith/Media/Pictures/Ultrawide Wallpapers/"
WP_Centre="/home/keith/Media/Pictures/Ultrawide Wallpapers/"
WP_Right="/home/keith/Media/Pictures/Ultrawide Wallpapers/"

usage() {
cat << EOF
Usage: $(basename -s .sh $0)
  [--centre <Wallpaper for Centre Monitor>]
  [--left   <Wallpaper for Left Monitor>]
  [--right  <Wallpaper for Right Monitor>]
EOF
}

main() {
    feh                     \
    --bg-scale              \
                            \
    "$WP_Centre"            \
    "$WP_Left"              \
    "$WP_Right"
}

while [[ $# > 0 ]]; do
    key="$1"
    case $key in
        --centre)
            WP_Centre="$2"
            shift
            ;;
        --left)
            WP_Left="$2"
            shift
            ;;
        --right)
            WP_Right="$2"
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo "Unrecognized Option '$key'"
            usage
            exit 1
            ;;
    esac
    shift
done

main
