#!/bin/sh
apt-get install git vim jq

# Yes I know this is a little nasty, but please be kind :-)
mkdir -p /etc/apache2/mods-available/
echo "<IfModule mod_dir.c>\n\tDirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm\n</IfModule>">/etc/apache2/mods-available/dir.conf
