#!/bin/bash

set -e

if [ ! -d ~/.ssh ]; then
  mkdir -p ~/.ssh;
fi
touch ~/.ssh/known_hosts
ssh-keyscan -H "$host" >>~/.ssh/known_hosts

temp=$(mktemp -d)

echo "$key" >"$temp/key"
chmod 700 "$temp/key"

function sftp-command() {
  echo "$@" | sftp -b - -i "$temp/key" "$user@$host" 2>&1
}

function sftp-test-connection() {
  sftp-command "exit" >/dev/null
}

function sftp-full-list() {
  sftp-command "ls -fl $1" |
    sed -n '/sftp>/,$p' |
    tail -n +2
}

function sftp-list-files() {
  sftp-full-list "$1" |
    sed -n -e '/^-/p' |
    awk '{print "'"$1"'/"$9}'
}

function sftp-list-directories() {
  sftp-full-list "$1" |
    sed -n -e '/^d/p' |
    awk '{print "'"$1"'/"$9}'
}

function sftp-list-files-recursively() {
  files=$(sftp-list-files "$1")
  directories=$(sftp-list-directories "$1")
  echo "$files"
  for directory in $directories; do
    sftp-list-files-recursively "$directory" &
  done
  wait
}

function sftp-list-directories-recursively() {
  directories=$(sftp-list-directories "$1")
  echo "$directories"
  for directory in $directories; do
    sftp-list-directories-recursively "$directory" &
  done
  wait
}

function sftp-mirror-local() {
  echo "Finding remote files recursively…"
  remote_files=$(sftp-list-files-recursively "$path" | tr -s " \t\r\n" "\n" | sort | uniq)
  echo "Finding remote directories recursively…"
  remote_directories=$(sftp-list-directories-recursively "$path" | tr -s " \t\r\n" "\n" | sort | uniq)
  echo "Found $(echo "$remote_files" | wc -l) remote files, $(echo "$remote_directories" | wc -l) remote directories."

  local_files=$(find public -type f -printf '%P\n' | awk '{print "'"$path"'/"$0}' | sort | uniq)
  local_directories=$(find public -type d -printf '%P\n' | awk '{print "'"$path"'/"$0}' | sort | uniq)
  echo "Found $(echo "$local_files" | wc -l) local files, $(echo "$local_directories" | wc -l) local directories."

  removable_files=$(comm -23 <(echo "$remote_files") <(echo "$local_files") | tr "\n" " ")
  removable_directories=$(comm -23 <(echo "$remote_directories") <(echo "$local_directories") | tr "\n" " ")
  echo "Found $(echo "$removable_files" | wc -l) remote-only files, $(echo "$removable_directories" | wc -l) remote-only directories."

  echo "Uploading local files…"
  sftp-command put -R public "$path" >/dev/null

  echo "Removing remote-only files…"
  for file in $removable_files; do
    sftp-command rm "$file" >/dev/null
  done
  echo "Removing remote-only directories…"
  for directory in $removable_directories; do
    sftp-command rmdir "$directory" >/dev/null
  done
}

if ! sftp-test-connection; then
  rm -r "$temp"
  exit 1
fi

sftp-mirror-local

rm -r "$temp"
exit 0
