#!/bin/bash -eux

while true
do
  cd /domains
  for domain in `ls . -I backups -I trash`
  do
    echo $domain
    cd /domains/$domain
    if [ -f ./scripts/pre-backup ]
    then
      ./scripts/pre-backup
    fi
    duplicity --volsize 500 --full-if-older-than ${FULL_FREQUENCY} --asynchronous-upload /domains/$domain ${PROTOCOL}://${BACKUP_DESTINATION}//backups/$domain
  done
  sleep ${INC_FREQUENCY}
done
