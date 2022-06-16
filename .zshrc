# Prompt
PROMPT="%F{red}┌[%f%F{cyan}%m%f%F{red}]─[%f%F{yellow}%D{%H:%M-%d/%m}%f%F{red}]─[%f%F{magenta}%d%f%F{red}]%f"$'\n'"%F{red}└╼%f%F{green}$USER%f%F{yellow}$%f"
# Export PATH$
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:$PATH

# alias
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#####################################################
# Auto completion / suggestion
# Jobs: suggest files / foldername / histsory bellow the prompt
# Requires: zsh-autosuggestions (packaging by Debian Team)
# Jobs: Fish-like suggestion for command histor
# Select all suggestion instead of top on result only
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2

# Save type history for completion and easier life
setopt appendhistory
ZDOTDIR="$HOME/.zsh"
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000

# Useful alias for benchmarking programs
# require install package "time" sudo apt install time
# alias time="/usr/bin/time -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'"
# Display last command interminal
echo -en "\e]2;Parrot Terminal\a"
preexec () { print -Pn "\e]0;$1 - Parrot Terminal\a" }

# add for User
## aliases
alias mocp="mocp -T hybrid -y"
alias xclip="xclip -selection c"

## fonction
texbuild() {
    filename=`echo $1 | cut -d "." -f 1`
    docker run --rm -it -v $(pwd):/workdir paperist/alpine-texlive-ja \
        sh -c "uplatex $1 ;dvipdfmx  $filename.dvi"
    rm $filename.dvi $filename.log -f
    }


mark2pdf(){
    filename=`echo $1 | cut -d "." -f 1`
    docker run --rm -v $(pwd):/data frozenbonito/pandoc-eisvogel-ja:plantuml \
    --listings \
    -N \
    --toc \
    -V linkcolor=blue \
    -V table-use-row-colors=true \
    -V titlepage=true \
    -V toc-own-page=true \
    -V toc-title="目次" \
    -o $filename.pdf \
    $filename.md
}
setopt magic_equal_subst

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# sh -c "$(curl -fsSL https://git.io/zinit-install)"
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light littleq0903/gcloud-zsh-completion
zinit light zsh-users/zsh-syntax-highlighting
zinit load marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit ice depth=1; zinit light romkatv/powerlevel10k
source "$HOME/.zsh/.zshrc"

# Flutter 
export PATH="$PATH:$HOME/develop/flutter/bin"
export CHROME_EXECUTABLE="/usr/bin/vivaldi-stable"

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

#Go lang
export GOPATH=~/.go
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# ls_extended
alias ls="lsd"

# deno
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"


# Google Cloud SDK
export CLOUDSDK_PYTHON=$(which python3)

# Dart webdev
export PATH="$PATH":"$HOME/.pub-cache/bin"

# popd / pushd
pushd () {
    builtin pushd "$@" > /dev/null
}

popd () {
    builtin popd "$@" > /dev/null
}
export pushd popd

# direnv
eval "$(direnv hook zsh)"

