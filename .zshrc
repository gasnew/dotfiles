# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Auto-load ssh keys
zstyle :omz:plugins:ssh-agent identities id_ed25519
plugins=(git ssh-agent)

# Ansible managed
# zsh version: 5.7.1
# antigen version: 

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gnew/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export TERM="xterm-256color"
export EDITOR="vim"
export PATH="$PATH:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"

HIST_STAMPS="yyyy-mm-dd"
UPDATE_ZSH_DAYS="30"
COMPLETION_WAITING_DOTS="true"

# ADOTDIR="$HOME/.antigen"

ANTIGEN_BUNDLES="$HOME/.antigen/bundles"
ANTIGEN_PLUGIN_UPDATE_DAYS="30"
ANTIGEN_SYSTEM_UPDATE_DAYS="30"


source "$HOME/.antigen/antigen/antigen.zsh"

antigen use oh-my-zsh


antigen bundle command-not-found
antigen bundle docker
antigen bundle fancy-ctrl-z
antigen bundle git-extras
antigen bundle gnu-utils
antigen bundle systemd
antigen bundle python
antigen bundle tmux
antigen bundle zsh_reload
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle popstas/zsh-command-time
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle urbainvaes/fzf-marks
antigen bundle ytet5uy4/fzf-widgets
# will fixed in zsh-autosuggestion v0.4 - https://github.com/zsh-users/zsh-autosuggestions/pull/218
if (( ZSHRC_LOAD_ONCE++ == 0 )); then
    antigen bundle zdharma/fast-syntax-highlighting@v1.2
fi
antigen bundle git
antigen bundle joel-porquet/zsh-dircolors-solarized

# POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k/powerlevel9k.zsh-theme

# antigen theme bhilburn/powerlevel9k powerlevel9k

antigen apply

###

source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme
ZSH_THEME="powerlevel10k/powerlevel10k"

unsetopt share_history


autoload -Uz copy-earlier-word
zle -N copy-earlier-word

# aliases
alias 'gs'="git status"
alias 'gc'="git commit"
alias 'gch'="git checkout"
alias 'gd'="git diff"
alias 'ga'="git add"
alias 'gl'="git log"
alias 'gp'="git pull"

# fzf
export FZF_TMUX=0
export FZF_DEFAULT_OPTS="--height 100% --reverse"

# fzf-widgets: fzf-change-reset-dir
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
declare -p FZF_WIDGETS_OPTS > /dev/null 2>&1 && FZF_WIDGETS_OPTS[insert-history]="--exact"
declare -p FZF_WIDGET_OPTS > /dev/null 2>&1 && FZF_WIDGET_OPTS[insert-history]="--exact"

# zsh-autosuggestions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=15
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240" # gray highlight

# powerlevel9k
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_STATUS_VERBOSE=0

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs vcs command_execution_time time)
DEFAULT_USER=$USER
POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=false
POWERLEVEL9K_ALWAYS_SHOW_USER=false

POWERLEVEL9K_CUSTOM_COMMAND_TIME="zsh_command_time"
POWERLEVEL9K_CUSTOM_COMMAND_TIME_BACKGROUND="248"
POWERLEVEL9K_CUSTOM_COMMAND_TIME_FOREGROUND="000"

# https://github.com/bhilburn/powerlevel9k#command_execution_time
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD="3"

POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_RPROMPT_ON_NEWLINE=false
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="255"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="024"
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="255"
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="024"
POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="255"
POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="124"

POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="255"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="240"
POWERLEVEL9K_DIR_HOME_FOREGROUND="255"
POWERLEVEL9K_DIR_HOME_BACKGROUND="240"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="255"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="240"
POWERLEVEL9K_DIR_ETC_FOREGROUND="255"
POWERLEVEL9K_DIR_ETC_BACKGROUND="240"
POWERLEVEL9K_DIR_PATH_HIGHLIGHT_FOREGROUND="255"
POWERLEVEL9K_DIR_PATH_HIGHLIGHT_BACKGROUND="240"

POWERLEVEL9K_VCS_CLEAN_BACKGROUND="100"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="094"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="094"
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="232"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="232"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="232"

POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="000"
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="248"

# Aliases
alias suser='su -'
alias vim='nvim'

source /etc/profile
# user configs
[[ -r /etc/zsh/zshrc.local ]] && source /etc/zsh/zshrc.local
[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

unset NPM_CONFIG_PREFIX
export PATH="$PATH:$(yarn global bin)"

# source ~/.virtualenvs/dev/bin/activate

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# hotkeys
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '^@' fzf-select-widget
bindkey '^@.' fzf-edit-dotfiles
bindkey '^@c' fzf-change-directory
bindkey '^@f' fzf-edit-files
bindkey '^@k' fzf-kill-processes
bindkey '^@s' fzf-exec-ssh
bindkey '^\' fzf-change-recent-directory
bindkey '^r' fzf-insert-history
bindkey '^xf' fzf-insert-files
bindkey '^xd' fzf-insert-directory
bindkey '^@g' fzf-select-git-widget
bindkey '^@ga' fzf-git-add-files
bindkey '^@gc' fzf-git-change-repository
bindkey '^@gco' fzf-git-checkout-branch
bindkey '^@gd' fzf-git-delete-branches
bindkey '^@gh' fzf-select-github-widget
bindkey '^@ghi' fzf-github-show-issue
bindkey '^@ghe' fzf-github-edit-issue
bindkey '^@gho' fzf-github-open-issue
bindkey '^@ghc' fzf-github-close-issue
bindkey '^@ghco' fzf-github-comment-issue
bindkey '^@d' fzf-select-docker-widget
bindkey '^@dk' fzf-docker-kill-containers
bindkey '^@dl' fzf-docker-logs-container
bindkey '^@dr' fzf-docker-remove-containers
bindkey '^@dri' fzf-docker-remove-images
bindkey '^@drv' fzf-docker-remove-volumes
bindkey '^@dsa' fzf-docker-start-containers
bindkey '^@dso' fzf-docker-stop-containers
bindkey '^T' autosuggest-accept

