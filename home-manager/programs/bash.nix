{ pkgs, ... }:
let
  myBashIt = pkgs.fetchFromGitHub {
    owner = "jbotwell";
    repo = "my_bash_it";
    rev = "main";
    sha256 = "04cpshj9ap8vdzkwdl0d3bwimhfy4kcvwd64vx3x9gpalxvr8cjb";
  };
in {
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    export PATH=$PATH:/home/john/.npm/bin:/home/john/.dotnet/tools
    export BASH_IT="/home/john/.bash_it"
    # export BASH_IT="/home/john/code/my_bash_it"
    export BASH_IT_THEME="bobby"

    alias et="emacsclient -nw"
    alias xc='xclip -sel clip'
    alias bashbare='bash --noprofile --norc'

    ch() {
      tmux split-window -h bash -c "curl cht.sh/$1 | less"
    }
    eval "$(thefuck --alias)"

    set -o vi

    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi

    source "$BASH_IT"/bash_it.sh'';
  home.file.".bash_it".source = myBashIt;
}
