#!/bin/bash

# Bing wallpapers
# Cesário Garcia Mil-Homens
# cesario@cesariogarcia.com
# https://www.cesariogarcia.com

# 1. Execute this script the first time and set "bingwallpaper.jpg" as wallpaper and lockscreen
# 2. Config $wallpaperPath (line 13 of this script) for the full path of where you want "bingwallpaper.jpg" to be (it should be on the user Pictures folder)
# 3. On the terminal execute the following command, this will check for new updates every two hours
# crontab -e
# Insert the following code -> "0 */2 * * * /bin/bash /home/username/scripts/bingwallpapers.sh >/dev/null 2>&1"

## Config wallpaper path
wallpaperPath="/home/user/Pictures/Wallpapers"
backgroundPath="/home/user/Programs"

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
			cp $wallpaperPath"/"$fileName $backgroundPath"/background.jpg"
			
			# The following code is to change KDE wallpaper
			dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript 'string:
            var Desktops = desktops();                                                                                                                       
            for (i=0;i<Desktops.length;i++) {
                    d = Desktops[i];
                    d.wallpaperPlugin = "org.kde.image";
                    d.currentConfigGroup = Array("Wallpaper",
                                                "org.kde.image",
                                                "General");
                    d.writeConfig("Image", "'$backgroundPath'/background.jpg");
            }'
			
		fi
else
    echo "Offline"
fi
