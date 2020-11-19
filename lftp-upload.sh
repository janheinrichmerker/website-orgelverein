#!/bin/bash

lftp=$(mktemp -d)

echo "$key" >"$lftp/key"

cat >"$lftp/script" <<EOL
set sftp:connect-program ssh -i $lftp/key -v -oStrictHostKeyChecking=accept-new
open -u $user sftp://$host
local pwd
local ls
pwd
ls
mirror -eRvvv public $path
EOL

cat "$lftp/script"

lftp -f "$lftp/script"

rm -r "$lftp"
