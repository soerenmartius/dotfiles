# =============================================================================
#                                   Functions
powerlevel9k_random_color(){
    printf "%03d" $[${RANDOM}%234+16] #random between 16-250
}

zsh_wifi_signal(){
    local signal=$(nmcli -t device wifi | grep '^*' | awk -F':' '{print $6}')
    local color="yellow"
    [[ $signal -gt 75 ]] && color="green"
    [[ $signal -lt 50 ]] && color="red"
    echo -n "%F{$color}\uf1eb" # \uf1eb is 
}

# =============================================================================
#                                   Variables
# =============================================================================
# Common ENV variables
export TERM="xterm-256color"
export SHELL="/bin/zsh"
export EDITOR="vim"

# Fix Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# color formatting for man pages
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;36m'     # begin blink
export LESS_TERMCAP_so=$'\e[1;33;44m'  # begin reverse video
export LESS_TERMCAP_us=$'\e[1;37m'     # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal

export MANPAGER='less -s -M -R +Gg'

# Directory coloring
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
    export CLICOLOR=true
    export LSCOLORS='exfxcxdxbxGxDxabagacad'
fi

if [[ $OSTYPE = (linux)* ]]; then
    export LS_OPTIONS='--color=auto'
fi

# Common aliases
alias rm="rm -v"
alias cp="cp -v"
alias mv="mv -v"
alias ls="ls $LS_OPTIONS -hFtr"
alias ll="ls $LS_OPTIONS -lAhFtr"
alias dig="dig +nocmd any +multiline +noall +answer"

disable -r time       # disable shell reserved word
alias time='time -p ' # -p for POSIX output

# =============================================================================
#                                   Plugins
# =============================================================================
# Check if zplug is installed

[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# oh-my-zsh
zplug "robbyrussell/oh-my-zsh", use:"lib/*.zsh"

# Load theme
zplug "mafredri/zsh-async", from:github, use:async.zsh
zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme, from:github, at:next, as:theme

zplug "chrissicool/zsh-256color"
zplug "mollifier/anyframe"

# Miscellaneous commands
zplug "k4rthik/git-cal", as:command
zplug "peco/peco", as:command, from:gh-r, use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf, use:"*${(L)$(uname -s)}*amd64*"
zplug "junegunn/fzf", use:"shell/*.zsh"

# Enhanced cd
zplug "b4b4r07/enhancd", use:init.sh

# Bookmarks and jump
zplug "jocelynmallon/zshmarks"

# Enhanced dir list with git features
zplug "supercrabtree/k"

# Jump back to parent directory
zplug "tarrasch/zsh-bd"

# Simple zsh calculator
zplug "arzzen/calc.plugin.zsh"

# Directory colors
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin
zplug "pinelibg/dircolors-solarized-zsh"

zplug "plugins/common-aliase",     from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/copydir",           from:oh-my-zsh
zplug "plugins/copyfile",          from:oh-my-zsh
zplug "plugins/cp",                from:oh-my-zsh
zplug "plugins/dircycle",          from:oh-my-zsh
zplug "plugins/encode64",          from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh
zplug "plugins/tmux",              from:oh-my-zsh
zplug "plugins/tmuxinator",        from:oh-my-zsh
zplug "plugins/urltools",          from:oh-my-zsh
zplug "plugins/web-search",        from:oh-my-zsh
zplug "plugins/z",                 from:oh-my-zsh
zplug "plugins/fancy-ctrl-z",      from:oh-my-zsh

# Supports oh-my-zsh plugins and the like
if [[ $OSTYPE = (darwin)* ]]; then
    zplug "lib/clipboard",         from:oh-my-zsh
    zplug "plugins/osx",           from:oh-my-zsh
    zplug "plugins/brew",          from:oh-my-zsh, if:"(( $+commands[brew] ))"
    zplug "plugins/macports",      from:oh-my-zsh, if:"(( $+commands[port] ))"
fi

zplug "plugins/git",               from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/golang",            from:oh-my-zsh, if:"(( $+commands[go] ))"
zplug "plugins/node",              from:oh-my-zsh, if:"(( $+commands[node] ))"
zplug "plugins/npm",               from:oh-my-zsh, if:"(( $+commands[npm] ))"
zplug "plugins/bundler",           from:oh-my-zsh, if:"(( $+commands[bundler] ))"
zplug "plugins/gem",               from:oh-my-zsh, if:"(( $+commands[gem] ))"
zplug "plugins/rvm",               from:oh-my-zsh, if:"(( $+commands[rvm] ))"
zplug "plugins/pip",               from:oh-my-zsh, if:"(( $+commands[pip] ))"
zplug "plugins/sudo",              from:oh-my-zsh, if:"(( $+commands[sudo] ))"
zplug "plugins/gpg-agent",         from:oh-my-zsh, if:"(( $+commands[gpg-agent] ))"
zplug "plugins/systemd",           from:oh-my-zsh, if:"(( $+commands[systemctl] ))"
zplug "plugins/docker",            from:oh-my-zsh, if:"(( $+commands[docker] ))"
zplug "plugins/docker-compose",    from:oh-my-zsh, if:"(( $+commands[docker-compose] ))"
zplug "plugins/terraform",         from:oh-my-zsh, if:"(( $+commands[terraform] ))"
zplug "plugins/vagrant",           from:oh-my-zsh, if:"(( $+commands[vagrant] ))"

#zplug "djui/alias-tips"
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"

# zsh-syntax-highlighting must be loaded after executing compinit command
# and sourcing other plugins
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3

# syntax highlight
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# =============================================================================
#                                   Options
# =============================================================================
setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Dont overwrite history
setopt auto_list
setopt auto_menu
setopt auto_pushd
setopt extended_history         # Also record time and duration of commands.
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Dont display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.
setopt hist_ignore_space        # Ignore commands that start with space.
setopt inc_append_history
setopt interactive_comments
setopt no_beep
setopt no_hist_beep
setopt no_list_beep
setopt magic_equal_subst
setopt notify
setopt print_eight_bit
setopt print_exit_value
setopt prompt_subst
setopt pushd_ignore_dups
setopt share_history            # Share history between multiple shells
setopt transient_rprompt


bindkey -v
bindkey -v '^?' backward-delete-char
bindkey '^[[Z' reverse-menu-complete
#bindkey '^@' anyframe-widget-cd-ghq-repository
#bindkey '^r' anyframe-widget-put-history

#function cd() {
#   builtin cd $@ && ls;
#}

# Watching other users
watch=(notme)         # Report login/logout events for everybody except ourself.
LOGCHECK=60           # Time (seconds) between checks for login/logout activity.
REPORTTIME=5          # Display usage statistics for commands running > 5 sec.

# Key timeout and character sequences
KEYTIMEOUT=1
WORDCHARS='*?_-[]~=./&;!#$%^(){}<>'

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# =============================================================================
#                                Key Bindings
# =============================================================================

# Common CTRL bindings.
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line
bindkey "^R" history-incremental-pattern-search-backward
bindkey "^F" history-incremental-pattern-search-forward

# Do not require a space when attempting to tab-complete.
bindkey "^i" expand-or-complete-prefix

# Fixes for alt-backspace and arrows keys
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
#bindkey "^[[C" forward-word
#bindkey "^[[D" backward-word


tcsh-backward-word () {
    local WORDCHARS="${WORDCHARS:s#./#}"
    zle emacs-backward-word
}
zle -N tcsh-backward-word
bindkey '\e[1;3D' tcsh-backward-word
bindkey '\e^[[D' tcsh-backward-word # tmux

tcsh-forward-word () {
    local WORDCHARS="${WORDCHARS:s#./#}"
    zle emacs-forward-word
}
zle -N tcsh-forward-word
bindkey '\e[1;3C' tcsh-forward-word
bindkey '\e^[[C' tcsh-backward-word # tmux

tcsh-backward-delete-word () {
    local WORDCHARS="${WORDCHARS:s#./#}"
    zle backward-delete-word
}
zle -N tcsh-backward-delete-word
bindkey "^[^?" tcsh-backward-delete-word # urxvt

# =============================================================================
#                                   Startup
# =============================================================================


[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
DIRCOLORS_SOLARIZED_ZSH_THEME="256dark"

# Install plugins if there are plugins that have not been installed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

if zplug check "junegunn/fzf-bin"; then
    export FZF_DEFAULT_OPTS="--height 40% --reverse --border --inline-info --color=dark,bg+:235,hl+:10,pointer:5"
fi

if zplug check "sindresorhus/pure"; then
    PURE_CMD_MAX_EXEC_TIME=0
    PURE_PROMPT_SYMBOL="%F{124}➜ %f"
    #PURE_PROMPT_SYMBOL="%F{124}⇢  %f"
fi

if zplug check "geometry-zsh/geometry"; then
    GEOMETRY_PROMPT_PLUGINS=(git exec_time)

    GEOMETRY_COLOR_EXIT_VALUE="magenta"         # prompt symbol color when exit value is != 0

    PROMPT_GEOMETRY_EXEC_TIME=true
    PROMPT_GEOMETRY_COMMAND_MAX_EXEC_TIME=0

    PROMPT_GEOMETRY_COLORIZE_ROOT=true
    PROMPT_GEOMETRY_RPROMPT_ASYNC=true
    PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
fi

if zplug check "mollifier/anyframe"; then
    # expressly specify to use fzf
    zstyle ":anyframe:selector:" use fzf
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey "^[[1;5A" history-substring-search-up
    bindkey "^[[1;5B" history-substring-search-down
fi

if zplug check "zsh-users/zsh-syntax-highlighting"; then
    typeset -gA ZSH_HIGHLIGHT_STYLES ZSH_HIGHLIGHT_PATTERNS

    ZSH_HIGHLIGHT_STYLES[default]='none'
    ZSH_HIGHLIGHT_STYLES[cursor]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
    ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
    ZSH_HIGHLIGHT_STYLES[path]='fg=white,underline'
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=grey,underline'
    ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=white'
    ZSH_HIGHLIGHT_STYLES[path_approx]='fg=white'
    ZSH_HIGHLIGHT_STYLES[globbing]='fg=green'
    ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=green'
    ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue'
    ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='none'
    ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
    ZSH_HIGHLIGHT_STYLES[assign]='none'

    ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)
fi

if zplug check "zsh-users/zsh-autosuggestions"; then
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=075'
fi

if zplug check "b4b4r07/enhancd"; then
    ENHANCD_FILTER="fzf:peco:percol"
    ENHANCD_COMMAND="c"
fi

if zplug check "b4b4r07/zsh-history-enhanced"; then
    ZSH_HISTORY_FILE="$HISTFILE"
    ZSH_HISTORY_FILTER="fzf:peco:percol"
    ZSH_HISTORY_KEYBIND_GET_BY_DIR="^r"
    ZSH_HISTORY_KEYBIND_GET_ALL="^r^a"
fi

if zplug check "bhilburn/powerlevel9k"; then

    DEFAULT_USER=$USER
    P9K_MODE="nerdfont-complete"

    # Easily switch primary foreground/background colors


    P9K_TIME_ICON="\uF017" # 
    P9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
    P9K_COMMAND_EXECUTION_TIME_PRECISION=1

    P9K_BACKGROUND_JOBS_FOREGROUND="123"

    P9K_USER_DEFAULT_ICON="\uF415" # 
    P9K_USER_ROOT_ICON=$'\uFF03' # ＃


    P9K_HOST_LOCAL_ICON="\uF109 "   # 
    P9K_HOST_REMOTE_ICON="\uF489 "  # 
    P9K_SSH_ICON="\uF489 "          # 

    P9K_STATUS_VERBOSE=false
    P9K_DIR_OMIT_FIRST_CHARACTER=false

    P9K_CONTEXT_ALWAYS_SHOW=false
    P9K_CONTEXT_ALWAYS_SHOW_USER=true

    P9K_LEFT_SUBSEGMENT_SEPARATOR_ICON="%F{232}\uE0BD%f"
    P9K_RIGHT_SUBSEGMENT_SEPARATOR_ICON="%F{232}\uE0BD%f"

    P9K_PROMPT_ON_NEWLINE=false
    P9K_RPROMPT_ON_NEWLINE=false

    P9K_STATUS_VERBOSE=true
    P9K_STATUS_CROSS=true
    P9K_PROMPT_ADD_NEWLINE=true

    P9K_MULTILINE_FIRST_PROMPT_PREFIX_ICON="%F{$PROMPT_COLOR}%f"
    P9K_MULTILINE_LAST_PROMPT_PREFIX_ICON="%F{$PROMPT_COLOR}➜ %f"

    P9K_LEFT_PROMPT_ELEMENTS=(context dir dir_writable vcs)
    P9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs command_execution_time time)

    P9K_VCS_GIT_GITHUB_ICON="\uF09b"    # 
    P9K_VCS_GIT_BITBUCKET_ICON="\uF171" # 
    P9K_VCS_GIT_GITLAB_ICON="\uF296"    # 
    P9K_VCS_GIT_ICON="\uF1d3"           # 
fi

# Then, source plugins and add commands to $PATH
zplug load

# =============================================================================
#                                 Completions
# =============================================================================
zstyle ':completion:' completer _complete _match _approximate
zstyle ':completion:' group-name ''
zstyle ':completion:' special-dirs true
zstyle ':completion:' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:' use-cache true
zstyle ':completion:' verbose yes
zstyle ':completion::default' menu select=2
zstyle ':completion::descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:options' description 'yes'


# zstyle
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*:descriptions' format '%U%F{yellow}%d%f%u'

zstyle ':completion:*' rehash true
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# case-insensitive (all), partial-word and then substring completion
zstyle ":completion:*" matcher-list \
    "m:{a-zA-Z}={A-Za-z}" \
    "r:|[._-]=* r:|=*" \
    "l:|=* r:|=*"

zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"

# =============================================================================
#                                 CUSTOM
# =============================================================================

# HUB
alias git='hub'

# PYTHON & PIP
alias python='/usr/local/bin/python3'
alias pip='/usr/local/bin/pip3'

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# git: use system ssh for git, otherwise UseKeychain option doesn't work
export GIT_SSH=/usr/bin/ssh
alias gpm='git checkout master; git pull origin master'

# GO
export PATH=$PATH:/usr/local/go/bin
export GOPATH="$HOME/Sites/Golang"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# finally, export the PATH
export PATH="$PATH"
