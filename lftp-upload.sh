#!/bin/bash

lftp=$(mktemp -d)

echo "$key" > "$lftp/key"

cat > "$lftp/script" << EOL
set sftp:connect-program ssh -i $lftp/key -l $user -oStrictHostKeyChecking=accept-new
open sftp://$host
mirror -eR public $path
EOL

lftp -f "$lftp/script"

rm -r "$lftp"
