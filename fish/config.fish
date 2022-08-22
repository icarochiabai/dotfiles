if status is-login
	if -z $DISPLAY; and test "$(tty)" = "/dev/tty1"
		Hyprland
	end

if status is-interactive
    # Commands to run in interactive sessions can go here
    function fish_greeting
     
    end
end
