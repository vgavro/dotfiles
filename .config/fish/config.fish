# Start X at login
if status --is-login
    if [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ]
        exec startx -- -keeptty
    end
end

# Ubuntu fish update (as of Ubuntu 16 contains 2.2 only)
# https://launchpad.net/~fish-shell/+archive/ubuntu/release-2
# Debian/other fish update (as of Debian 8 contains 2.2 only)
# https://software.opensuse.org/download.html?project=shells%3Afish%3Arelease%3A2&package=fish

if [ "$TERM" = "rxvt-unicode-256color" ]
    if not test -e /usr/share/terminfo/r/rxvt-unicode-256color
        # TODO: remove echo on supressing fish warning
        echo "set xterm-256color"
        set -gx TERM xterm-256color
    end
end
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8
set -x EDITOR vim
set -x SHELL /usr/bin/fish

if [ -d $HOME/.bin ]
    set PATH $HOME/.bin $PATH
end

if status --is-interactive
    if not type -q "fisher"
        echo 'Installing fisher'
        curl -#Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
        . ~/.config/fish/functions/fisher.fish
    end
    fisher fzf tuvistavie/fish-fastdir 2>/dev/null
    if  not type -q fzf
        if type -q __fzf_install
            __fzf_install
        else
            # removed from last versions of fish extension?
            # read -l -p 'echo "fzf not found. Install locally? [y/N]"' install_fzf
            # For some reason not work under tmux for old fish shells (2.3.1 for example)
            set -l install_fzf "y"
            if [ "$install_fzf" = "y" ]
                git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
                # NOTE: interactive prompt display nothing for some reason
                # (in case some arguments would be added)
                ~/.fzf/install --completion --key-bindings --no-update-rc
            end
        end
    end
end

set -g FZF_LEGACY_KEYBINDINGS 0
set -g FZF_DEFAULT_OPTS "--exact"

# Fix for su not setting proper $USER
set USER (whoami)

function su
    /bin/su --shell=/usr/bin/fish $argv
end

# Needed for proper displaying hostname on remote after "sudo -s"
function sudo
    /usr/bin/sudo SSH_CLIENT=$SSH_CLIENT $argv
end

# Autoset virtualenv
set VIRTUAL_ENV_DISABLE_PROMPT 1  # disable changing prompt
function __virtualenv_hook --on-variable PWD --description 'Auto activate virtualenv'
  status --is-command-substitution; and return
  if [ -f ./env/bin/activate.fish -a "$VIRTUAL_ENV" != "$PWD/env" ]
      source ./env/bin/activate.fish
  else
      if not [ -z $VIRTUAL_ENV ]
          if not echo $PWD | grep -q '^'(echo $VIRTUAL_ENV | sed -e 's/\/env$//')
              if type -q deactivate
                  deactivate
              end
          end
      end
  end
end

# Autoset last directory
if status --is-interactive
    if [ -f ~/.lastdir ]
        cd (cat ~/.lastdir) 2>/dev/null
    end
end
function __lastdir_write --on-variable PWD --description 'Auto write last dir'
    pwd > ~/.lastdir &
end

# Compatibility
set fish_greeting ""  # default in newer versions
if not type -q "prompt_hostname"
    function prompt_hostname
        hostname
    end
end
if not type -q "__fish_vcs_prompt"
    function __fish_vcs_prompt
        if type -q git
            set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
            if [ "$branch" != "" ]
                echo -ns '(' "$branch" ')'
            end
        end
    end
end
if echo $version | grep -q '^2.2'
    # fzf plugin compatibility (without multiline support)
    # See https://github.com/fisherman/fzf/pull/38 for more info
    function __fzf_reverse_isearch
        builtin history | eval "__fzfcmd +s --tiebreak=index --toggle-sort=ctrl-r" \
                               "$FZF_DEFAULT_OPTS $FZF_REVERSE_ISEARCH_OPTS" \
                               "-q (commandline)" | read select
        if not test -z $select
            commandline -rb "$select"
            commandline -f repaint
        end
    end
    function __fzf_find_and_execute
        builtin history | eval "__fzfcmd +s -m --tiebreak=index --toggle-sort=ctrl-r" \
                               "$FZF_DEFAULT_OPTS $FZF_FIND_AND_EXECUTE_OPTS" | read select
        printf "\nexecuting: $select\n"
        eval $select
        commandline -f repaint
    end
end

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
# set __fish_git_prompt_char_dirtystate '✚'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '↑'
# set __fish_git_prompt_char_upstream_behind '↓'
# Compability
set __fish_git_prompt_char_dirtystate '+'
set __fish_git_prompt_char_stagedstate '^'
set __fish_git_prompt_char_stashstate '%'
set __fish_git_prompt_char_upstream_ahead '>'
set __fish_git_prompt_char_upstream_behind '<'

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    history merge &

    if [ $USER = root -o $USER = toor ]
        set_color red --bold 
        set prompt_char "#"
    else
        set_color blue --bold
        set prompt_char ">"
    end
    echo -ns $USER (set_color normal)

    if not [ -z "$SSH_CLIENT" ]
        set_color --background blue
        echo -ns (set_color white --bold) "@" (prompt_hostname)
    end
    # echo -ns (set_color white --bold) "@" (prompt_hostname)
    echo -ns (set_color normal) ":"

    echo -ns  (set_color $fish_color_cwd) (prompt_pwd)

    if not [ -z "$VIRTUAL_ENV" ]
        echo -ns (set_color cyan --bold) "(env)"
    end

    set -l vcs_prompt (__fish_vcs_prompt)
    if [ "$vcs_prompt" != "" ]
        set_color yellow --bold
        if type -q string
            echo -n (string replace -a ' ' '' -- $vcs_prompt)
        else
            echo -n $vcs_prompt
        end
    end

    if [ $last_status -ne 0 ]
        echo -ns (set_color red --bold) $last_status
    end
    set_color normal

    # if [ $CMD_DURATION -gt (math "1000 * 10") ]
    #     # was working more than 10 seconds
    #     set -l hours (math "$CMD_DURATION / 3600000")
    #     set -l mins (math "$CMD_DURATION % 3600000 / 60000")
    #     set -l secs (math "$CMD_DURATION % 60000 / 1000")
    #     set -l time_str ""
    #     if [ $hours -gt 0 ]
    #         set time_str {$time_str}{$hours}"h"
    #     end
    #     if [ $mins -gt 0 ]
    #         set time_str {$time_str}{$mins}"m"
    #     end
    #     echo -ns "[$time_str" "$secs" "s]"
    # end

    echo -ns "$prompt_char" " "
end

function _mp3_convert_cp1251
  count $argv > /dev/null; and set dir $argv; or set dir $PWD
  find $dir -iname '*.mp3' -print0 | xargs -0 mid3iconv -eCP1251 --remove-v1
end
alias _https_update_time "tlsdate -v -H mail.google.com"
alias _urxvt_terminus_fontsize "printf '\33]50;%s%d\007' 'xft:xos4 Terminus:size='"
