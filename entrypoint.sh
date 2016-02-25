#!/bin/bash -eux

while true
do
  cd /domains
  START=`date +%s`
  for domain in `ls .`
  do
    echo $domain
    cd /domains/$domain
    if [ -f ./scripts/pre-backup ]
    then
      ./scripts/pre-backup
    fi
    duplicity remove-older-than 10D --force file:///backups/$domain
    duplicity --volsize 500 --full-if-older-than 7D --asynchronous-upload /domains/$domain file:///backups/$domain
  done
  sleep $((3600 - `date +%s` + $START))
done
