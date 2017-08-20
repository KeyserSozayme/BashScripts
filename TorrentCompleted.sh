#! /usr/bin/env bash

export TR_AUTH=:
TOR_FILE="$TR_TORRENT_DIR/$TR_TORRENT_NAME"
NOW="$(date +"%F %T")"
EMAIL="/tmp/Email $NOW.log"
RPC="transmission-remote localhost:11920 -ne"

# Remove Torrent
${RPC} -t "$TR_TORRENT_ID" --remove

cat > "$EMAIL" << EOF
At $TR_TIME_LOCALTIME the following file finished downloading...

-> $TOR_FILE <-

Thank You
EOF

cat "$EMAIL" | mutt -s 'A torrent Has Completed!' KingKeithC@gmail.com
rm "$EMAIL" "$HOME/sent"


