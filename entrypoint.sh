#!/bin/bash -eux

START = `date +%s`

cd /domains

while true
do
  for domain in `ls .`
  do
    echo $domain
    cd /domains/$domain
    ./scripts/pre-backup
    duplicity remove-older-than 10D --force file:///backups/$domain
    duplicity --volsize 500 --full-if-older-than 7D --asynchronous-upload /domains/$domain file:///backups/$domain
  done
  sleep $((3600 - `date +%s` - $START))
done
