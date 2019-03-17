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
wallpaperPath="/home/username/Pictures"

## Do not edit anything bellow
wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "Online"
	imageName=$(curl -s "https://www.bing.com/HPImageArchive.aspx?format=xml&idx=0&n=1&mkt=en-US" | grep -o -m 1 "/th?id=.*.&amp;rf=NorthMale_1920x1080.jpg&amp;pid=hp")
    prefix="/th?id=";
	imageName=${imageName#$prefix};
	suffix="&amp;rf=NorthMale_1920x1080.jpg&amp;pid=hp";
	imageName=${imageName%$suffix};
		if [ -e $wallpaperPath"/"$imageName ]
		then
			echo "$imageName found."
		else
			echo "$imageName not found."
			wget "https://www.bing.com/th?id="$imageName -O $wallpaperPath/$imageName
			cp $wallpaperPath"/"$imageName $wallpaperPath"/"bingwallpaper.jpg
		fi
else
    echo "Offline"
fi
