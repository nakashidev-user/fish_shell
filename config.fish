if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (/opt/homebrew/bin/brew shellenv)
    set fish_greeting ""
    #eval (/opt/homebrew/bin/brew shellenv)
    set -gx TERM xterm-256color
    # theme
    set -g theme_color_scheme terminal-dark
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_display_user yes
    set -g theme_hide_hostname no
    set -g theme_hostname always

    export LSCOLORS=gxfxcxdxbxegedabagacad


    # aliases
    alias ls "ls -p -G"
    alias la "ls -A"
    alias lla "ll -A"
    alias cl clear
    alias vi nvim
    alias g git
    alias gg "go run"
    alias cdl "cd .."
    command -qv nvim && alias vim nvim

    set -gx EDITOR nvim

    set -gx PATH bin $PATH
    set -gx PATH ~/bin $PATH
    set -gx PATH ~/.local/bin $PATH

    # NodeJS
    set -gx PATH node_modules/.bin $PATH

    # set -gx PATH ~/node/node-v15.0.0/node_modules/ $PATH

    # nodebrew
    set -gx PATH ~/.nodebrew/current/bin $PATH

    set -gx PATH ~/.cargo/bin $PATH

    # Go
    set -g GOPATH $HOME/go
    set -gx PATH $GOPATH/bin $PATH

    #FZF
    set -U FZF_LEGACY_KEYBINDINGS 0
    set -U FZF_DISABLE_KEYBINDINGS 1


    # google-cloud-sdk
    source "/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc"

    switch (uname)
        case Darwin
            source (dirname (status --current-filename))/config-osx.fish
        case Linux
            source (dirname (status --current-filename))/config-linux.fish
        case '*'
            source (dirname (status --current-filename))/config-windows.fish
    end

    set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
    if test -f $LOCAL_CONFIG
        source $LOCAL_CONFIG
    end
end
