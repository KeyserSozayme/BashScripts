#! /usr/bin/env bash

TOR_FILE="$TR_TORRENT_DIR/$TR_TORRENT_NAME"
NOW="$(date +"%F %T")"
EMAIL="/tmp/Email $NOW.log"
RPC="transmission-remote localhost:11920"

# Remove Torrent
${RPC} -t "$TR_TORRENT_ID" --remove

# Email Notification to be Sent
cat > "$EMAIL" << EOF
At $TR_TIME_LOCALTIME the following file finished downloading...

-> $TOR_FILE <-

Thank You
EOF

# Send Email
cat "$EMAIL" | mutt -s 'A torrent Has Completed!' KingKeithC@gmail.com
rm "$EMAIL" "$HOME/sent"


