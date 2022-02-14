# Adapted from https://raw.githubusercontent.com/sorin-ionescu/prezto/master/modules/editor/init.zsh
# Sets key bindings.
#
# Variables
#
# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

# Use human-friendly identifiers.
zmodload zsh/terminfo
typeset -gA key_info
key_info=(
  'Control'         '\C-'
  'ControlLeft'     '\e[1;5D \e[5D \e\e[D \eOd'
  'ControlRight'    '\e[1;5C \e[5C \e\e[C \eOc'
  'ControlPageUp'   '\e[5;5~'
  'ControlPageDown' '\e[6;5~'
  'Escape'       '\e'
  'Meta'         '\M-'
  'Backspace'    "^?"
  'Delete'       "^[[3~"
  'F1'           "$terminfo[kf1]"
  'F2'           "$terminfo[kf2]"
  'F3'           "$terminfo[kf3]"
  'F4'           "$terminfo[kf4]"
  'F5'           "$terminfo[kf5]"
  'F6'           "$terminfo[kf6]"
  'F7'           "$terminfo[kf7]"
  'F8'           "$terminfo[kf8]"
  'F9'           "$terminfo[kf9]"
  'F10'          "$terminfo[kf10]"
  'F11'          "$terminfo[kf11]"
  'F12'          "$terminfo[kf12]"
  'Insert'       "$terminfo[kich1]"
  'Home'         "$terminfo[khome]"
  'PageUp'       "$terminfo[kpp]"
  'End'          "$terminfo[kend]"
  'PageDown'     "$terminfo[knp]"
  'Up'           "$terminfo[kcuu1]"
  'Left'         "$terminfo[kcub1]"
  'Down'         "$terminfo[kcud1]"
  'Right'        "$terminfo[kcuf1]"
  'BackTab'      "$terminfo[kcbt]"
)

# Set empty $key_info values to an invalid UTF-8 sequence to induce silent
# bindkey failure.
for key in "${(k)key_info[@]}"; do
  if [[ -z "$key_info[$key]" ]]; then
    key_info[$key]='�'
  fi
done

#
# External Editor
#

# Allow command line editing in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line

#
# Functions
#
# Runs bindkey but for all of the keymaps. Running it with no arguments will
# print out the mappings for all of the keymaps.
function bindkey-all {
  local keymap=''
  for keymap in $(bindkey -l); do
    [[ "$#" -eq 0 ]] && printf "#### %s\n" "${keymap}" 1>&2
    bindkey -M "${keymap}" "$@"
  done
}

# Expands .... to ../..
function expand-dot-to-parent-directory-path {
  if [[ $LBUFFER = *.. ]]; then
    LBUFFER+='/..'
  else
    LBUFFER+='.'
  fi
}
zle -N expand-dot-to-parent-directory-path

# Inserts 'sudo ' at the beginning of the line.
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo

# Expand aliases
function glob-alias {
  zle _expand_alias
  zle expand-word
  zle magic-space
}
zle -N glob-alias

# history-substring-search
function _history_substring_search_config() {
    bindkey -M vicmd "k" history-substring-search-up
    bindkey -M vicmd "j" history-substring-search-down

    # keyinfo not available here
    bindkey -M viins '^[[A' history-substring-search-up
    bindkey -M viins '^[[B' history-substring-search-down
}


# Reset to default key bindings.
bindkey -d

#
# Vi Key Bindings
#

# Edit command in an external editor emacs style (v is used for visual mode)
bindkey -M vicmd "$key_info[Control]X$key_info[Control]E" edit-command-line

# Undo/Redo
bindkey -M vicmd "u" undo
bindkey -M vicmd "$key_info[Control]R" redo

if (( $+widgets[history-incremental-pattern-search-backward] )); then
  bindkey -M vicmd "?" history-incremental-pattern-search-backward
  bindkey -M vicmd "/" history-incremental-pattern-search-forward
else
  bindkey -M vicmd "?" history-incremental-search-backward
  bindkey -M vicmd "/" history-incremental-search-forward
fi

# Toggle comment at the start of the line.
bindkey -M vicmd "#" vi-pound-insert

# Unbound keys in vicmd and viins mode will cause really odd things to happen
# such as the casing of all the characters you have typed changing or other
# undefined things. In emacs mode they just insert a tilde, but bind these keys
# in the main keymap to a noop op so if there is no keybind in the users mode
# it will fall back and do nothing.
function _prezto-zle-noop {  ; }
zle -N _prezto-zle-noop
local -a unbound_keys
unbound_keys=(
  "${key_info[F1]}"
  "${key_info[F2]}"
  "${key_info[F3]}"
  "${key_info[F4]}"
  "${key_info[F5]}"
  "${key_info[F6]}"
  "${key_info[F7]}"
  "${key_info[F8]}"
  "${key_info[F9]}"
  "${key_info[F10]}"
  "${key_info[F11]}"
  "${key_info[F12]}"
  "${key_info[PageUp]}"
  "${key_info[PageDown]}"
  "${key_info[ControlPageUp]}"
  "${key_info[ControlPageDown]}"
)
for keymap in $unbound_keys; do
  bindkey -M viins "${keymap}" _prezto-zle-noop
  bindkey -M vicmd "${keymap}" _prezto-zle-noop
done

# Keybinds for all keymaps
for keymap in 'viins' 'vicmd'; do
  bindkey -M "$keymap" "$key_info[Home]" beginning-of-line
  bindkey -M "$keymap" "$key_info[End]" end-of-line
  bindkey -M "$keymap" "$key_info[Control]D" kill-buffer
done

# Keybinds for all vi keymaps
for keymap in viins vicmd; do
  # Ctrl + Left and Ctrl + Right bindings to forward/backward word
  for key in "${(s: :)key_info[ControlLeft]}"
    bindkey -M "$keymap" "$key" vi-backward-word
  for key in "${(s: :)key_info[ControlRight]}"
    bindkey -M "$keymap" "$key" vi-forward-word
done

# Keybinds for viins
bindkey -M viins "$key_info[Insert]" overwrite-mode
bindkey -M viins "$key_info[Delete]" delete-char
bindkey -M viins "$key_info[Backspace]" backward-delete-char

bindkey -M viins "$key_info[Left]" backward-char
bindkey -M viins "$key_info[Right]" forward-char

# Expand history on space.
bindkey -M viins ' ' magic-space

# Clear screen.
bindkey -M viins "$key_info[Control]L" clear-screen

# Expand command name to full path.
bindkey -M viins "$key_info[Escape]E" expand-cmd-path

# Duplicate the previous word.
bindkey -M viins "$key_info[Control]B" copy-prev-shell-word

# push current command on stack, and pop after next
bindkey -M viins "$key_info[Control]Q" push-line-or-edit

# Bind Shift + Tab to go to the previous menu item.
bindkey -M viins "$key_info[BackTab]" reverse-menu-complete

# Complete in the middle of word.
bindkey -M viins "$key_info[Control]I" expand-or-complete

# expand .... to ../..
bindkey -M viins "." expand-dot-to-parent-directory-path

# Insert 'sudo ' at the beginning of the line.
bindkey -M viins "$key_info[Control]X$key_info[Control]S" prepend-sudo

# control-space expands all aliases, including global
bindkey -M viins "$key_info[Control] " glob-alias

# Delete key deletes character in vimcmd cmd mode instead of weird default functionality
bindkey -M vicmd "$key_info[Delete]" delete-char

# Do not expand .... to ../.. during incremental search.
bindkey -M isearch . self-insert 2> /dev/null

bindkey -M viins "$key_info[Control]F" vi-forward-word
bindkey -M viins "$key_info[Control]E" vi-add-eol


bindkey -v
unset key{,map,_bindings}
