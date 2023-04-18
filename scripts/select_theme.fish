#!/usr/bin/fish
set has_default_flag 0

for arg in $argv
    switch $arg
        case --default
            set has_default_flag 1
            break
    end
end

if test $has_default_flag -eq 1
    set theme --default
else if test (count $argv) -ne 0
    set theme $argv[1]
else
    set theme (ls ~/Themes/ | wofi --show dmenu -i -b -p "Choose your theme!")
end

source ~/.config/scripts/handle_theme.fish $theme
