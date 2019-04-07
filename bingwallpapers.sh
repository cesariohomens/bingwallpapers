#!/bin/bash

# Bing wallpapers
# Cesário Garcia Mil-Homens
# cesario@cesariogarcia.com
# https://www.cesariogarcia.com

# 1. Execute this script the first time and set "bingwallpaper.jpg" as wallpaper and lockscreen
# 2. Config $wallpaperPath (line 13 of this script) for the full path of where you want "bingwallpaper.jpg" to be (it should be on the user Pictures folder)
# 3. On the terminal execute the following command, this will check for new updates every two hours
# crontab -l | { cat; echo "0 */2 * * * /bin/bash /home/username/scripts/bingwallpapers.sh >/dev/null 2>&1"; } | crontab -

## Config wallpaper path
wallpaperPath="/home/cesario/Pictures"

## Do not edit anything bellow
wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "Online"
	imageLink=$(curl -s "https://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US" | grep -o -m 1 "/th?id=.*.jpg");
	imageLink=${imageLink%&*};
	prefix="/th?id=";
	fileName=${imageLink#$prefix};

		if [ -e $wallpaperPath"/"$fileName ]
		then
			echo "$fileName found."
		else
			echo "$fileName not found."
			wget "https://www.bing.com/th?id="$fileName -O $wallpaperPath/$fileName
			cp $wallpaperPath"/"$fileName $wallpaperPath"/"bingwallpaper.jpg
		fi
else
    echo "Offline"
fi
