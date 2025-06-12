# config.fishに以下の設定を追加
# set -g __fish_git_prompt_showdirtystate yes
# set -g __fish_git_prompt_showstashstate yes
# set -g __fish_git_prompt_showuntrackedfiles yes
# set -g __fish_git_prompt_showupstream yes
# set -g __fish_git_prompt_color_branch yellow
# set -g __fish_git_prompt_color_upstream_ahead green
# set -g __fish_git_prompt_color_upstream_behind red
#
# # Status Chars
# set -g __fish_git_prompt_char_dirtystate '⚡'
# set -g __fish_git_prompt_char_stagedstate '→'
# set -g __fish_git_prompt_char_untrackedfiles '☡'
# set -g __fish_git_prompt_char_stashstate '↩'
# set -g __fish_git_prompt_char_upstream_ahead '+'
# set -g __fish_git_prompt_char_upstream_behind -
#
# function fish_prompt
#     if [ $status -eq 0 ]
#         set status_face (set_color green)'('(set_color red)'d'(set_color white)' ≧▽≦'(set_color red)'b'(set_color green)')' (set_color white)'⇨ '
#     else
#         set status_face (set_color blue)'<(;'(set_color white)' -_-'(set_color blue)')> ' (set_color white)'⇨ '
#     end
#
#     # Gitの情報を取得
#     set -l git_info (fish_git_prompt)
#
#     # プロンプトを表示
#     echo -n (set_color cyan)(prompt_pwd)
#     echo -n (set_color normal)$git_info
#     echo -n (set_color normal)' '
#     echo -n $status_face
# end
# function fish_prompt
#     set prompt (set_color green)(prompt_pwd)
#     imgcat $HOME/Pictures/mine/shiro.png
#     echo (set_color blue) $prompt (set_color green)' > '
# end
# ================================================================================================

function fish_prompt
end # In case this file gets loaded non-interactively, e.g by conda
status is-interactive || exit

_tide_remove_unusable_items
_tide_cache_variables
_tide_parent_dirs
source (functions --details _tide_pwd)

set -l prompt_var _tide_prompt_$fish_pid
set -U $prompt_var # Set var here so if we erase $prompt_var, bg job won't set a uvar

# SETUVAR tide_git_bg_color:normal
# SETUVAR tide_git_bg_color_unstable:normal
# SETUVAR tide_git_bg_color_urgent:normal
# SETUVAR tide_git_color_branch:brgreen
# SETUVAR tide_git_color_conflicted:brred
# SETUVAR tide_git_color_dirty:bryellow
# SETUVAR tide_git_color_operation:brred
# SETUVAR tide_git_color_staged:bryellow
# SETUVAR tide_git_color_stash:brgreen
# SETUVAR tide_git_color_untracked:brblue
# SETUVAR tide_git_icon:\uf1d3
# SETUVAR tide_git_truncation_length:24


set_color normal | read -l color_normal
status fish-path | read -l fish_path

# _tide_repaint prevents us from creating a second background job
function _tide_refresh_prompt --on-variable $prompt_var --on-variable COLUMNS
    set -g _tide_repaint
    commandline -f repaint
end

if contains newline $_tide_left_items # two line prompt initialization
    test "$tide_prompt_add_newline_before" = true && set -l add_newline '\n'

    set_color $tide_prompt_color_frame_and_connection -b normal | read -l prompt_and_frame_color

    set -l column_offset 5
    test "$tide_left_prompt_frame_enabled" = true &&
        set -l top_left_frame "$prompt_and_frame_color╭─" &&
        set -l bot_left_frame "$prompt_and_frame_color╰─" &&
        set column_offset 3
    test "$tide_right_prompt_frame_enabled" = true &&
        set -l top_right_frame "$prompt_and_frame_color─╮" &&
        set -l bot_right_frame "$prompt_and_frame_color─╯" &&
        set column_offset (math $column_offset-2)

    if test "$tide_prompt_transient_enabled" = true
        eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && jobs -p | count | read -lx _tide_jobs
        $fish_path -c \"set _tide_pipestatus \$_tide_pipestatus
set _tide_parent_dirs \$_tide_parent_dirs
PATH=\$(string escape \"\$PATH\") CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $prompt_var (_tide_2_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -g _tide_last_pid \$last_pid
    end

    if not set -q _tide_transient
        math \$COLUMNS-(string length -V \"\$$prompt_var[1][1]\$$prompt_var[1][3]\")+$column_offset | read -lx dist_btwn_sides

        echo -n $add_newline'$top_left_frame'(string replace @PWD@ (_tide_pwd) \"\$$prompt_var[1][1]\")'$prompt_and_frame_color'
        string repeat -Nm(math max 0, \$dist_btwn_sides-\$_tide_pwd_len) '$tide_prompt_icon_connection'

        echo \"\$$prompt_var[1][3]$top_right_frame\"
    end
    echo -n \e\[0J\"$bot_left_frame\$$prompt_var[1][2]$color_normal \"
end

function fish_right_prompt
    set -e _tide_transient || string unescape \"\$$prompt_var[1][4]$bot_right_frame$color_normal\"
end"
    else
        eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && jobs -p | count | read -lx _tide_jobs
        $fish_path -c \"set _tide_pipestatus \$_tide_pipestatus
set _tide_parent_dirs \$_tide_parent_dirs
PATH=\$(string escape \"\$PATH\") CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $prompt_var (_tide_2_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -g _tide_last_pid \$last_pid
    end

    math \$COLUMNS-(string length -V \"\$$prompt_var[1][1]\$$prompt_var[1][3]\")+$column_offset | read -lx dist_btwn_sides

    echo -ns $add_newline'$top_left_frame'(string replace @PWD@ (_tide_pwd) \"\$$prompt_var[1][1]\")'$prompt_and_frame_color'
    string repeat -Nm(math max 0, \$dist_btwn_sides-\$_tide_pwd_len) '$tide_prompt_icon_connection'
    echo -ns \"\$$prompt_var[1][3]$top_right_frame\"\n\"$bot_left_frame\$$prompt_var[1][2]$color_normal \"
end

function fish_right_prompt
    string unescape \"\$$prompt_var[1][4]$bot_right_frame$color_normal\"
end"
    end
else # one line prompt initialization
    test "$tide_prompt_add_newline_before" = true && set -l add_newline '\0'

    math 5 -$tide_prompt_min_cols | read -l column_offset
    test $column_offset -ge 0 && set column_offset "+$column_offset"

    if test "$tide_prompt_transient_enabled" = true
        eval "
function fish_prompt
    set -lx _tide_status \$status
    _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && jobs -p | count | read -lx _tide_jobs
        $fish_path -c \"set _tide_pipestatus \$_tide_pipestatus
set _tide_parent_dirs \$_tide_parent_dirs
PATH=\$(string escape \"\$PATH\") CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $prompt_var (_tide_1_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -g _tide_last_pid \$last_pid
    end

    if set -q _tide_transient
        echo -n \e\[0J
        add_prefix= _tide_item_character
        echo -n '$color_normal '
    else
        math \$COLUMNS-(string length -V \"\$$prompt_var[1][1]\$$prompt_var[1][2]\")$column_offset | read -lx dist_btwn_sides
        string replace @PWD@ (_tide_pwd) $add_newline \$$prompt_var[1][1]'$color_normal '
    end
end

function fish_right_prompt
    set -e _tide_transient || string unescape \"\$$prompt_var[1][2]$color_normal\"
end"
    else
        eval "
function fish_prompt
    _tide_status=\$status _tide_pipestatus=\$pipestatus if not set -e _tide_repaint
        jobs -q && jobs -p | count | read -lx _tide_jobs
        $fish_path -c \"set _tide_pipestatus \$_tide_pipestatus
set _tide_parent_dirs \$_tide_parent_dirs
PATH=\$(string escape \"\$PATH\") CMD_DURATION=\$CMD_DURATION fish_bind_mode=\$fish_bind_mode set $prompt_var (_tide_1_line_prompt)\" &
        builtin disown

        command kill \$_tide_last_pid 2>/dev/null
        set -g _tide_last_pid \$last_pid
    end

    math \$COLUMNS-(string length -V \"\$$prompt_var[1][1]\$$prompt_var[1][2]\")$column_offset | read -lx dist_btwn_sides
    string replace @PWD@ (_tide_pwd) $add_newline \$$prompt_var[1][1]'$color_normal '
end

function fish_right_prompt
    string unescape \"\$$prompt_var[1][2]$color_normal\"
end"
    end
end

# Inheriting instead of evaling because here load time is more important than runtime
function _tide_on_fish_exit --on-event fish_exit --inherit-variable prompt_var
    set -e $prompt_var
end

if test "$tide_prompt_transient_enabled" = true
    function _tide_enter_transient
        # If the commandline will be executed or is empty, and the pager is not open
        # Pager open usually means selecting, not running
        # Can be untrue, but it's better than the alternative
        if commandline --is-valid || test -z "$(commandline)" && not commandline --paging-mode
            set -g _tide_transient
            set -g _tide_repaint
            commandline -f repaint
        end
        commandline -f execute
    end

    bind \r _tide_enter_transient
    bind \n _tide_enter_transient
    bind -M insert \r _tide_enter_transient
    bind -M insert \n _tide_enter_transient
end
