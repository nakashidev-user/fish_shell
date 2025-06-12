if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (/opt/homebrew/bin/brew shellenv)
    set fish_greeting ""
    #eval (/opt/homebrew/bin/brew shellenv)
    # set -gx TERM xterm-256color
    set -gx TERM tmux-256color
    # theme
    # set -g theme_color_scheme terminal-dark
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_display_user yes
    set -g theme_hide_hostname no
    set -g theme_hostname always

    export LSCOLORS=gxfxcxdxbxegedabagacad


    # aliases
    alias ls "eza --icons"
    alias lsl "eza -lhB --icons"
    alias la "eza -a --icons"
    alias lal "eza -lhBa --icons"
    alias lss "eza -alrhB --icons --sort=size"
    alias lsd "eza -alrhB --icons --sort=date"
  # Date Modified
    alias vi nvim
    alias lv lvim
    alias g git
    alias gg "go run"
    alias py python3
    alias cdl "cd .."
    alias memo "~/.config/fish/scripts/memo.sh"
    alias ide "~/.config/fish/scripts/ide.sh"
    alias google "~/.config/fish/scripts/google.sh"
    # alias wi "wezterm imgcat"
    alias lg lazygit
    alias c. "cursor ."
    alias gw "git switch"
    alias c "claude"
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
    # set -Ux GOPATH $HOME/go
    # set -x GOROOT (go1.20 env GOROOT)
    # set -x PATH $HOME/sdk/go1.20/bin $PATH
    # set -x PATH $PATH (go env GOPATH)/bin
    # /Users/nakashimadays365/sdk/go1.20

    set -x GOENV_ROOT $HOME/.goenv
    set -x PATH $GOENV_ROOT/bin $PATH
    # eval (goenv init -)
    set -x PATH $PATH (go env GOPATH)/bin

    #Elixir
    set -gx PATH /opt/homebrew/bin/elixir $PATH

    #FZF
    set -U FZF_LEGACY_KEYBINDINGS 0
    set -U FZF_DISABLE_KEYBINDINGS 1

    #Cairo
    set -x PKG_CONFIG_PATH /usr/local/opt/cairo/lib/pkgconfig $PKG_CONFIG_PATH

    #Java
    set -gx PATH /usr/bin/Java $PATH

    #pvenv
    set -x PYENV_ROOT "$HOME/.pyenv"
    set -x PATH "$PYENV_ROOT/bin" $PATH
    status --is-interactive; and . (pyenv init -|psub)

    #dotnet
    set -x DOTNET_ROOT $HOME/dotnet
    set -x PATH $PATH $HOME/dotnet

    ##wezterm
    #set -x PATH "/Applications/WezTerm.app/Contents/MacOS" $PATH

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
