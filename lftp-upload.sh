#!/bin/bash

lftp=$(mktemp -d)

echo "$key" >"$lftp/key"


cat >"$lftp/script" <<EOL
set sftp:auto-confirm true
set sftp:connect-program ssh -a -x -i $lftp/key -v
open -u "$user", "sftp://$host"
pwd
ls
mirror -eRvvv public $path
exit
EOL

lftp -f "$lftp/script"

rm -r "$lftp"
