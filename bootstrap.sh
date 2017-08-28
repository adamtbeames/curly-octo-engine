#!/bin/sh
apt-get install git vim jq

echo "<IfModule mod_dir.c>\n\tDirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm\n</IfModule>">/etc/apache2/mods-enabled/dir.conf
