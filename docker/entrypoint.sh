#!/bin/sh

if ! [ "$PGID" -eq "$(id -g abc)" ]; then
  groupmod --non-unique --gid "$PGID" abc
fi

if ! [ "$PUID" -eq "$(id -u abc)" ]; then
  usermod --non-unique --uid "$PUID" abc
fi

echo 
echo PUID: $(id -u abc)
echo PGID: $(id -g abc)
echo PORT: $PORT
echo DIR_IS_NETSRV: $DIR_IS_NETSRV
echo DL_DECRYPTED_ISO: $DL_DECRYPTED_ISO
echo EXTRACT_DL_ARCHIVE: $EXTRACT_DL_ARCHIVE
echo 

chown -R abc:abc /vl-downloader/backend/downloads

su -c "node /vl-downloader/backend/src/main.js" abc
