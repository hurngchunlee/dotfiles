#!/bin/bash

cd ~

now=$(date +%Y%m%dT%H%M%S)

mkdir -p ~/backup

## backup PASS store, PGP and SSH keys configurations
tar cvzf ~/backup/backup-pass-pgp-ssh.${now}.tgz .password-store .gnupg .ssh

## backup owncloud and nexcloud configurations
tar cvzf ~/backup/backup-owncloud-nextcloud.${now}.tgz .config/ownCloud .config/nexcloud* .config/NextCloud*

## backup Joplin configurations and data
tar cvzf ~/backup/backup-joplin.${now}.tgz .config/Joplin .config/joplin-desktop

## backup brave configurations and plugins 
#tar cvzf ~/backup/backup-brave.${now}.tgz .config/BraveSoftware

## backup rambox 
tar cvzf ~/backup/backup-rambox.${now}.tgz .config/rambox

echo "For evolution backup, use the in-app backup/restore under 'File'"
