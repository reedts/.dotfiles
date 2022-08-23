# {{{                   Options
# history settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt HIST_IGNORE_SPACE

# setopts (taken from grml config)
# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# remove command lines from the history list when the first character on the
# line is a space
setopt histignorespace

# if a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
setopt auto_cd

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# display PID when suspending processes as well
setopt longlistjobs

# report the status of backgrounds jobs immediately
setopt notify

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all

# not just at the end
setopt completeinword

# Don't send SIGHUP to background processes when the shell exits.
setopt nohup

# make cd push the old directory onto the directory stack.
setopt auto_pushd

# avoid "beep"ing
setopt nobeep

# don't push the same dir twice.
setopt pushd_ignore_dups

# * shouldn't match dotfiles. ever.
setopt noglobdots

# enable null_glob
setopt null_glob

# use zsh style word splitting
setopt noshwordsplit

# don't error out when unset parameters are used
setopt unset

# }}}              END  Options

# {{{              Aliases
# aliases (taken from grml-config)
#a2# Execute \kbd{ls -lSrah}
alias dir="command ls -lSrah"
#a2# Only show dot-directories
alias lad='command ls -d .*(/)'
#a2# Only show dot-files
alias lsa='command ls -a .*(.)'
#a2# Only files with setgid/setuid/sticky flag
alias lss='command ls -l *(s,S,t)'
#a2# Only show symlinks
alias lsl='command ls -l *(@)'
#a2# Display only executables
alias lsx='command ls -l *(*)'
#a2# Display world-{readable,writable,executable} files
alias lsw='command ls -ld *(R,W,X.^ND/)'
#a2# Display the ten biggest files
alias lsbig="command ls -flh *(.OL[1,10])"
#a2# Only show directories
alias lsd='command ls -d *(/)'
#a2# Only show empty directories
alias lse='command ls -d *(/^F)'
#a2# Display the ten newest files
alias lsnew="command ls -rtlh *(D.om[1,10])"
#a2# Display the ten oldest files
alias lsold="command ls -rtlh *(D.Om[1,10])"
#a2# Display the ten smallest files
alias lssmall="command ls -Srl *(.oL[1,10])"
#a2# Display the ten newest directories and ten newest .directories
alias lsnewdir="command ls -rthdl *(/om[1,10]) .*(D/om[1,10])"
#a2# Display the ten oldest directories and ten oldest .directories
alias lsolddir="command ls -rthdl *(/Om[1,10]) .*(D/Om[1,10])"

alias ls='ls $LS_OPTIONS'
alias ll='ls -alh $LS_OPTIONS'
alias lt='ls -ltr $LS_OPTIONS'

# sv
alias svl='sudo sv status /var/service/*'
alias svgl='sv status ~/graphical/*'

# feh
alias f='feh -. -d --keep-zoom-vp'
# zathura
alias z='zathura'
# nvim
alias v='nvim'
alias vd='nvim -d'

# handlr (xdg-open deprecated)
alias xo='handlr open'

# rsync
alias copy='rsync -az --info=progress2'

#xbps aliases
alias xin='sudo xbps-install'
alias xrm='sudo xbps-remove'
alias xq='xbps-query'

# neomutt
alias nm='neomutt'

# matterhorn
alias mh='matterhorn'

alias mm='micromamba'
alias t='task'
alias tw='task project:work'

# }}}           END  Aliases

# {{{           Key Mappings
# }}}           END  Key Mappings

# {{{           Virtualenv
## Make virtualenv name appear in shell
#source /bin/virtualenvwrapper_lazy.sh
#function virtual_env_prompt () {
#	REPLY=${VIRTUAL_ENV+(${VIRTUAL_ENV:t}) }
#}

# }}}           END  Virtualenv

# {{{			Micromamba
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/home/julian/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/julian/.mamba";
__mamba_setup="$('/home/julian/.local/bin/micromamba' shell hook --shell zsh --prefix '/home/julian/.mamba' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/julian/.mamba/etc/profile.d/mamba.sh" ]; then
        . "/home/julian/.mamba/etc/profile.d/mamba.sh"
    else
        export PATH="/home/julian/.mamba/bin:$PATH"
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<
# }}}			END Micromamba

# {{{           FZF
export FZF_COMPLETION_TRIGGER='~~'
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# }}}           END FZF

# {{{           zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions \
  zsh-users/zsh-history-substring-search

# Prompt
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh" # pull behavior same as clone, source init.zsh
zinit light starship/starship


# Compatibility for Oh-My-Zsh plugins
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit cdclear -q

# Completions
zinit snippet OMZ::plugins/pip/pip.plugin.zsh
zinit ice blockf as'completion'
zinit snippet OMZ::plugins/pip/_pip

zinit snippet OMZ::plugins/man/man.plugin.zsh

zinit ice blockf as'completion'
zinit snippet OMZ::plugins/docker-compose/_docker-compose

zinit ice blockf as'completion'
zinit snippet OMZ::plugins/docker/_docker

zinit ice blockf
zinit light zsh-users/zsh-completions

zinit ice blockf
zinit light zpm-zsh/ssh

zinit snippet OMZ::plugins/rsync/rsync.plugin.zsh

zstyle ':plugin:zinit:ssh-agent-pass' add-all yes
zstyle ':plugin:zinit:ssh-agent-pass' agent-forwarding yes
zinit ice silent wait lucid
zinit light reedts/ssh-agent-pass


zinit ice pick'bd.zsh'
zinit light Tarrasch/zsh-bd

zinit ice pick'you-should-use.plugin.zsh'
zinit light MichaelAquilina/zsh-you-should-use

zinit light andsens/homeshick

# for dircolors
zinit ice atclone"dircolors -b ~/.dircolors > clrs.zsh" \
    atpull'%atclone' pick"clrs.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light zdharma-continuum/null

# }}}          END  zinit

# {{{           Profile

if [ -d $HOME/.zprofile.d/ ]; then
	if [ .(NF) ]; then
		for f in $HOME/.zprofile.d/*.zsh; do
			[ -r "$f" ] && . "$f"
		done
		unset f
	fi
fi

# }}}

# {{{          functions

_fzf_complete_pass() {
	_fzf_complete --multi --reverse --prompt="pass> " -- "$@" < <(
	fd . --extension=gpg  ~/.password-store --exec echo {.} | sed 's/.*password-store\/\(.*\)/\1/g'
)
}

# Runit related user functions
function svg() {
	sv "$1" $HOME/graphical/"$2"
}

# enable shared dirstack
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-file ${XDG_CACHE_HOME:-$HOME/.cache}/.chpwd-recent-dirs

# Report directory changes OSC-7 to foot
function osc7 {
    local LC_ALL=C
    export LC_ALL

    setopt localoptions extendedglob
    input=( ${(s::)PWD} )
    uri=${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-\/])/%${(l:2::0:)$(([##16]#match))}}
    print -n "\e]7;file://${HOSTNAME}${uri}\e\\"
}
add-zsh-hook -Uz chpwd osc7

# }}}       END functions

# {{{       Prompt
# Add prompt marker OSC-133 for prompt jumping
precmd_jumpmarker() {
	print -Pn "\e]133;A\e\\"
}
add-zsh-hook precmd precmd_jumpmarker


setopt no_list_ambiguous

zstyle ':completion:*' menu select yes

# }}}             END  Prompt

# vim: fdm=marker
