# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH



# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="fishy"

# Themes to test: kardan, sunaku, theunraveler, wezm

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

if [ -d ~/.local/bin/ ] ; then
    export PATH=~/.local/bin:$PATH
fi

if [ -d ~/.nodenv/bin ] ; then
    export PATH=~/.nodenv/bin:$PATH
fi

eval "$(nodenv init -)"

unsetopt hist_ignore_dups
setopt hist_ignore_all_dups

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export WORKON_HOME=~/.virtualenvs
export PROJECT_HOME=~/Programowanie/projekty
source ~/.local/bin/virtualenvwrapper.sh

function _get_theme_name {
  local file_name=$(basename $1)
  local theme_name="${file_name%.*}"
  echo $theme_name
}


function _set_vim_theme {
  local vim_theme_name=${1%-256}
  echo -e "if \0041exists('g:colors_name') || \
g:colors_name != '$vim_theme_name'\n  \
colorscheme $vim_theme_name\nendif" >| ~/.vimrc_background
}


function _get_color {
  echo $(cat ~/.current-colors.Xresources | grep "#define $1" | cut -d' ' -f3)
}

function _set_a_dunst_color {
  local property=$(echo $1 | cut -d '-' -f 2)
  local color=$(_get_color $2)
  sed -i -e "s/# \$$1/$property = \"$color\"/g" ~/.config/dunst/dunstrc
}

function _set_dunst_colors {
  (cd ~/.config/dunst; cp dunstrc-template dunstrc)

  _set_a_dunst_color frame-color base02
  _set_a_dunst_color background base01
  _set_a_dunst_color low-foreground base0B
  _set_a_dunst_color normal-foreground base05
  _set_a_dunst_color critical-foreground base08
}


function _set_theme {
  local theme_name=$(_get_theme_name $1)
  ln -sf $1 ~/.current-colors.Xresources
  xrdb ~/.Xresources
  _set_vim_theme $theme_name
  _set_dunst_colors
  i3-msg restart
  killall dunst &>/dev/null
  (dunst&)
  sleep 1s
  notify-send -u 'normal' 'Configuration' 'The theme "'$theme_name\
'" has been successfully set. For urxvt and neovim, changes will be \
visible only after starting new instances.'
}

function _create_set_theme_alias {
  local theme_name=$(_get_theme_name $1)
  alias 'theme-set-'$theme_name='_set_theme '$1
}

for f in $(find -L ~/.colors-xresources -type f -name "*.Xresources"); do
  _create_set_theme_alias $f
done

function theme-get-info {
  local current_theme_path=$(readlink -f ~/.current-colors.Xresources)
  local theme_name=$(_get_theme_name $current_theme_path)
  echo "The current color theme is $theme_name"
}
