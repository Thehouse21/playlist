#!/bin/sh
# Author: Luca Oltenau
# Version 0.1 - 10.10.2016
# 
# This simple script will generate a M3U playlist out of a specified folder containing media files,
# and add an URL to the path, so you can use the Playlist in conjunction with a Web Server as a simple Media Streaming System.
# All files will be scanned by ffprobe to obtain media duration, so please make sure it is installed on your system.
# On each run, the script will delete the previously generated Playlist file and replace with a new one.

#########
# Setup #
#########

## Please specify the folder you would like to scan. Don't add final /. (e.g. /var/www/media )
videopath=/var/www/media

## URL you would like to append to the path. Add / at the end. (e.g. https://www.example.com/media/)
URL=https://www.example.com/media/

## Uncomment if you would like to replace all spaces in the filenames by underscore, so streaming via http is possible.
## ATTENTION: This will rename ALL files in the folder (excluding subfolders)
find $videopath/ -depth -name "* *" -execdir rename 's/ /_/g' "{}" \;

## Specify your webservers User and Group. (user:group) You can find out by running ls -l in your www folder.
RIGHTS=web1:client1

## Uncomment if you would like to change ownership of the files to match webservers User and Group.
chown $RIGHTS $videopath



########
# Code #
########

# Removing old M3U Playlist
rm -f $videopath/liste.m3u

# Generate M3U Playlist by scanning media files and extracting duration with ffprobe.
for f in $videopath/*.m* $videopath/*.avi; do length=`ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $f | rev | cut -c8- | rev`; datei=`ls $f | xargs -n 1 basename | rev | cut -c5- | rev | sed -r 's/_/ /g'`; dateisauber=`ls $f | xargs -n 1 basename`; dateimitpfad=$URL$dateisauber; echo -e "#EXTINF:$length,$datei\n$dateimitpfad" >> $videopath/liste.m3u; done

# Add necessary line to M3U Playlist.
sed -i '1i#EXTM3U' $videopath/liste.m3u

# Change ownership of Playlist to match http user. Uncomment if not needed.
chown $RIGHTS $videopath/liste.m3u
