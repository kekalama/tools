#!/bin/bash

if [ -z "$1" ]
then
    printf "You need to define backup destination as a 1. argumeter\n"
    exit 1
else
    if [ -d "$1" ]
    then
	BACKUPDIR=$1
    else
	printf "No such backup directory"
	exit 1
    fi
fi;

if [ -z "$2" ]
then
    printf "You need to define current Drupal installation directory as a 2. parameter\n"
    exit 1
else
    if [ -d "$2" ]
    then
	CURRENTDIR=$2
    else
	printf "No such installation directory"
	exit 1
    fi
fi;

if [ -z "$3" ]
then
    printf "You need to define new Drupal directory as a 3th parameters\n"
    exit 1
else
    if [ -d "$3" ]
    then
	NEWDRUPALDIR=$3
    else
	printf "No such new drupal directory\n"
	exit 1
    fi
fi;


# Fixed set of files isn't long term solution
COREFILES=("authorize.php"
	   "CHANGELOG.txt"
	   "COPYRIGHT.txt"
	   "cron.php"
	   "includes"
	   "index.php"
	   "INSTALL.mysql.txt"
	   "INSTALL.pgsql.txt"
	   "install.php"
	   "INSTALL.sqlite.txt"
	   "INSTALL.txt"
	   "LICENSE.txt"
	   "MAINTAINERS.txt"
	   "misc"
	   "modules"
	   "profiles"
	   "README.txt"
	   "robots.txt"
	   "scripts"
	   "themes"
	   "update.php"
	   "UPGRADE.txt"
	   "web.config"
	   "xmlrpc.php"
	   )

printf "\nStarted to update Drupal 7 core files...\n"

# Preparation phase
rm -rf $BACKUPDIR/*
printf "...removed content from the backup directory\n"

# 1. Create backup of current installation
cp -r $CURRENTDIR/* $BACKUPDIR/
printf "...successfully created backup\n"

# 2. Remove current installation core files
for item in "${COREFILES[@]}"
do
    rm -rf $CURRENTDIR/"${item}"
done
printf "...successfully removed old core files\n"

# 3. Copy new files from new package
for item in "${COREFILES[@]}"
do
    cp -r $NEWDRUPALDIR/"${item}" $CURRENTDIR/
done
printf "...successfully copied new core files to current installation directory\n"

printf "Updated successfully Drupal 7 core files!\n"
