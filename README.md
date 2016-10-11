# M3U-Playlist-Generator-for-http-streaming---BASH-Script
This script will scan a directory for media files, obtain media duration and generate a M3U Playlist with URL path. 

# This simple script will generate a M3U playlist out of a specified folder containing media files,
# and add an URL to the path, so you can use the Playlist in conjunction with a Web Server as a simple Media Streaming System.
# All files will be scanned by ffprobe to obtain media duration, so please make sure it is installed on your system.
# On each run, the script will delete the previously generated Playlist file and replace with a new one.
