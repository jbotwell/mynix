{ pkgs, ... }:

{
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    export PATH=$PATH:/home/john/.npm/bin:/home/john/.dotnet/tools
    export BASH_IT="/home/john/.bash_it"
    export BASH_IT_THEME="bobby"

    alias et="emacsclient -nw"
    alias xc='xclip -sel clip'
    eval "$(thefuck --alias)"

    set -o vi

    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi

    source "$BASH_IT"/bash_it.sh'';
}
