if status is-interactive
    # Commands to run in interactive sessions can go here
    alias vim nvim
    alias icat 'kitty +kitten icat'
    alias createtheme ~/.config/scripts/create_theme.fish
    [ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
end
