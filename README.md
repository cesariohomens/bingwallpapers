# Bingwallpapers
A small script that downloads bing image of the day to your desktop and lockscreen.

# Install
1. Execute this script the first time and set "bingwallpaper.jpg" as wallpaper and lockscreen
2. Config $wallpaperPath (line 13 of this script) for the full path of where you want "bingwallpaper.jpg" to be (it should be on the user Pictures folder)
3. On the terminal execute the following command, this will check for new updates every two hours
```
crontab -l | { cat; echo "0 */2 * * * /bin/bash /home/username/scripts/bingwallpapers.sh >/dev/null 2>&1"; } | crontab -
```
