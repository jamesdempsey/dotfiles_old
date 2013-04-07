# This is strange: putting /usr/local/bin at the beginning of PATH messed up UTF-8
# characters in vim, but may be required by postgresql?
#
#export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
#export PATH=$PATH:$HOME/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/heroku/bin
export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/usr/local/heroku/bin

# Tab completion goodness
autoload -U compinit
compinit -i

# Disable autocorrect
unsetopt correct_all

# shell alias(es)
alias la='ls -la'

# git aliases
alias g='git'
alias gs='git status'
alias gco='git checkout'
alias gcm='git checkout master'
alias gcb='git checkout -b'
alias gb='git branch'
alias ga='git add'
alias gap='git add -p'
alias gm='git merge'
alias gc='git commit -m'
alias gca='git commit -am'
alias gl='git log -p'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdw='git diff --word-diff'
alias gsq='git commit --amend -C HEAD'
alias gp='git push'
alias gpl='git pull'
alias grm='git rebase master'

# rails alias(es)
alias sand='rails c --sandbox'

# Set iTerm window and tab titles
precmd () {
  if [[ $PWD == $HOME ]] {
    tab_title='~'
  } else {
    tab_title="$PWD:t"
  }
  window_title=${PWD/${HOME}/\~}
  echo -ne "\e]2;${window_title}\a"
  echo -ne "\e]1;${tab_title}\a"
}

# Kolo theme yanked from oh-my-zsh
autoload -U colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '%F{green}●'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}●'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{11}%r'
zstyle ':vcs_info:*' enable git svn

theme_precmd () {
  if [[ -n $(git rev-parse --git-dir 2> /dev/null) ]] {
    if [[ -n $(git status | grep 'Your branch is behind' 2> /dev/null) ]] {
      PULL=' %B%F{red}⬇'
    } else {
      PULL=''
    }

    if [[ -n $(git status | grep 'Your branch is ahead' 2> /dev/null) ]] {
      PUSH=' %B%F{yellow}⬆'
    } else {
      PUSH=''
    }

    if [[ -n $(git stash list 2> /dev/null) ]] {
      STASH=' %B%F{blue}⏏'
    } else {
      STASH=''
    }

    if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
      zstyle ':vcs_info:*' formats " [%b%c%u%B%F{green}]${STASH}${PUSH}${PULL}"
    } else {
      zstyle ':vcs_info:*' formats " [%b%c%u%B%F{red}●%F{green}]${STASH}${PUSH}${PULL}"
    }
  }
  vcs_info
}

setopt prompt_subst
PROMPT='%B%F{magenta}%c%B%F{green}${vcs_info_msg_0_}%B%F{magenta} %{$reset_color%}%% '
autoload -U add-zsh-hook
add-zsh-hook precmd  theme_precmd
source ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
unset MAILCHECK

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
