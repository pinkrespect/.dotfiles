path() { [[ -d "$1" ]] && export PATH="$1:$PATH" }
src()  { [[ -s "$1" ]] && source "$1" }


path "/usr/local/bin"             # OS X
path "$HOME/.tmux-do/bin"         # tmux-do

# RVM
path "$HOME/.rvm/bin"
src  "$HOME/.rvm/scripts/rvm"
export rvmsudo_secure_path=0

# Colorful Terminal
export TERM=xterm-256color

# OCaml
alias ml='ledit ocaml'