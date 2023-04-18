#!/usr/bin/fish
function load_default
    set has_default_flag 0

    for arg in $argv
        switch $arg
            case --default
                set has_default_flag 1
                break
        end
    end

    return (test $has_default_flag -eq 1)
end

function validate_option
    return (test -e "$HOME/Themes/$theme" && test "$theme" != "" && test "$theme" != "$CURRENT_THEME")
end

function clear
    pkill hyprpaper
    pkill waybar
end

function reload_theme
    cd ~/Themes/$CURRENT_THEME/hyprpaper/ ; nohup hyprpaper -c ~/Themes/$CURRENT_THEME/hyprpaper/*.conf > /dev/null  2>&1 &
    nohup waybar -c ~/Themes/$CURRENT_THEME/waybar/config -s ~/Themes/$CURRENT_THEME/waybar/style.css > /dev/null  2>&1 & 
    cp ~/Themes/$CURRENT_THEME/kitty/current-theme.conf ~/.config/kitty/ && kill -SIGUSR1 $(pgrep kitty)
    cp ~/Themes/$CURRENT_THEME/hyprland/theme.conf ~/.config/hypr/ && hyprctl update
end

set theme $argv[1]
if load_default $argv
    clear
    reload_theme
else if validate_option
    cp ~/.config/kitty/current-theme.conf ~/Themes/$CURRENT_THEME/kitty/ && kill -SIGUSR1 $(pgrep kitty)
    cp ~/.config/hypr/theme.conf ~/Themes/$CURRENT_THEME/hyprland/
    set -Ux CURRENT_THEME $theme
    clear
    reload_theme
    dunstify "$theme theme applied."
else
    if test "$theme" = "$CURRENT_THEME"
        dunstify "Selected theme is the current theme."
    else if test "$theme" != ""
        dunstify "Selected $theme theme not found."
    end
end


