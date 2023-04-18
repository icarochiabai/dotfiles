#!/usr/bin/fish

set dir (ls ~/Notes/ | wofi --show dmenu -i -b -p "Choose dir")

if test -e ~/Notes/$dir && test $dir != ""
    set note (ls ~/Notes/$dir/ | wofi --show dmenu -i -b -p "Choose note")
    set file ~/Notes/$dir/$note
    if test -e $file && test $note != ""
        kitty --hold -e nvim $file
    else
        if test $note != ""
            kitty -e nvim $file.md
        end
    end
else
    mkdir ~/Notes/$dir
end
