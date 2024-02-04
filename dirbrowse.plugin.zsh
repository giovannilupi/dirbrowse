# enables cycling through the directory stack using
# Option+Left/Right/Up
#
# left/right direction follows the order in which directories
# were visited, like left/right arrows do in a browser
# up direction visits the parent directory

# NO_PUSHD_MINUS syntax:
#  pushd +N: start counting from left of `dirs' output
#  pushd -N: start counting from right of `dirs' output

# -----------------------------------------------------------
# Dir cycling functions
# -----------------------------------------------------------

# Switch to new directory and push the current one onto the stack
switch-to-dir () {
  setopt localoptions nopushdminus
  [[ ${#dirstack} -eq 0 ]] && return 1

  while ! builtin pushd -q $1 &>/dev/null; do
    # We found a missing directory: pop it out of the dir stack
    builtin popd -q $1

    # Stop trying if there are no more directories in the dir stack
    [[ ${#dirstack} -eq 0 ]] && return 1
  done
}

# Insert previous directory and reset prompt
insert-cycledir () {
  switch-to-dir $1 || return

  local fn
  for fn (chpwd $chpwd_functions precmd $precmd_functions); do
    (( $+functions[$fn] )) && $fn
  done
  zle reset-prompt
}

# -----------------------------------------------------------
# Dispatching functions
# -----------------------------------------------------------

# Needed because bindkey cannot pass parameters to functions
insert-cycledir-left () {insert-cycledir +1}
zle -N insert-cycledir-left
insert-cycledir-right () {insert-cycledir -0}
zle -N insert-cycledir-right
insert-cycledir-up () {insert-cycledir ..}
zle -N insert-cycledir-up

# -----------------------------------------------------------
# Key binding
# -----------------------------------------------------------

# These sequences work on iTerm2 and VSCode for Option+<arrow>
# The up arrow will not work on Terminal.app, since it cannot 
# produce a key sequence for Option+Up
# Sequences can be changed for other systems
bindkey "^[[1;2D" insert-cycledir-left
bindkey "^[[1;2C" insert-cycledir-right
bindkey "^[[1;2A" insert-cycledir-up