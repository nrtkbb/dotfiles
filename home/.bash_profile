ulimit -S -n 1024

export PATH=~/bin:/usr/local/bin:$PATH:/usr/local/opt/git/share/git-core/contrib/diff-highlight
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=/Applications/Xcode6-Beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/:$PATH
export PATH=/usr/local/mysql/bin:$PATH

# for rbenv
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"

# for work
DOTS_WORK="$HOME/.bash_profile_work"
[ -f $DOTS_WORK ] && source $DOTS_WORK

# for home
DOTS_HOME="$HOME/.bash_profile_home"
[ -f $DOTS_HOME ] && source $DOTS_HOME

# gemのディレクトリへPATHを通す
GEM_SYM_PATH=`which gem`
if [ -f $GEM_SYM_PATH ]; then
  GEM_SYM_DIR=${GEM_SYM_PATH%/*}
  GEM_PATH=`readlink $GEM_SYM_PATH`
  GEM_DIR=${GEM_PATH%/*}
  export PATH=$GEM_SYM_DIR"/"$GEM_DIR:$PATH
fi

# chefのディレクトリへPATHを通す
CHEF_PATH='/opt/chef/bin'
if [ -d $CHEF_PATH ]; then
  export PATH=$CHEF_PATH":"$PATH
fi

source /usr/local/etc/bash_completion.d/git-completion.bash
function parse_git_branch {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1)/"
}
function proml {
  PS1="[\[\033[36m\]\w\[\033[0m\]]\$(parse_git_branch)\n\$ "
}
proml

export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls='ls -G'
alias ll='ls -alhG'
alias la='ls -aG'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias mvi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'
alias mvim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/mvim "$@"'
alias glog="git log --graph --pretty='format:%C(yellow)%h%Cblue%d%Creset %s %C(white)%an, %ar%Creset'"

export GIT_EDITOR=vim
export SVN_EDITOR=vim
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export ANDROID_HOME=/usr/local/opt/android-sdk
export NDK_ROOT=/usr/local/opt/android-ndk
export NDK_CCACHE=/usr/local/bin/ccache

export DISPLAY=:0.0
