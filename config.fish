if not status --is-interactive; exit; end

function __path
  switch (count $argv)
  case 1
    if perl -e "exit(!(grep(m{^$argv[1]\$},split(':', \$ENV{PATH}))) > 0)"; return; end

    # Append to $PATH
    set PATH $PATH "$argv[1]" ^/dev/null
  case 2
    if perl -e "exit(!(grep(m{^$argv[1]\$},split(':', \$ENV{PATH}))) > 0)"; return; end
    if [ "$argv[2]" != "--force" ]; return 1; end

    # Prepend to $PATH
    set PATH "$argv[1]" $PATH ^/dev/null
  case '*'
    return 1
  end
end


#
# lscolors
#
set -x LSCOLORS "Gxfxcxdxbxegedabagacad"
set -x LS_COLORS "di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
set -x TIME_STYLE "+%y%m%d"


#
# Fishrc
#
if not set -q TMUX; set TERM xterm-256color; end
__path "$HOME/.local/bin" --force
set -x LANG ko_KR.UTF-8

# Aliases
if type -q tmux; alias irc='tmux attach -t irc'; end

# Ruby
if begin; type -q ruby; and type -q gem; end
  set -x GEM_HOME (ruby -e 'print Gem.user_dir')
  __path "$GEM_HOME/bin"
end

# Golang
if type -q go
  set -x GOPATH ~/.go
  mkdir -p "$GOPATH/bin"
  __path "$GOPATH/bin"
end

# cargo install
if [ -d ~/.cargo/bin ]
  __path "$HOME/.cargo/bin"
end
# yarn global
if type -q yarn
  __path "$HOME/.config/yarn/global/node_modules/.bin"
end

# chips <https://github.com/xtendo-org/chips>
if [ -e ~/.config/chips/build.fish ] ; . ~/.config/chips/build.fish ; end

# pyenv
if [ -d ~/.pyenv ]
  __path "$HOME/.pyenv/bin" --force
  . (pyenv init -|psub)
  . (pyenv virtualenv-init -|psub)
end

# exa
if type -q exa
  alias l="exa -alh --group-directories-first"
  alias ll="exa -lh --group-directories-first"
end


functions --erase __path
