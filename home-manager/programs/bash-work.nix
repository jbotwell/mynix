{ pkgs, ... }:
let
  myBashIt = pkgs.fetchFromGitHub {
    owner = "jbotwell";
    repo = "my_bash_it";
    rev = "main";
    sha256 = "0dp5qhlvi7z6rr5jp0b1s6ri0azhskv8n5w2d4ammrwcm5rphcrq";
  };
in {
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    export PATH=$PATH:/Users/john_otwell/.npm/bin:/Users/john_otwell/.dotnet/tools:/Users/john_otwell/.config/emacs/bin:/Users/john_otwell/.local/bin
    export BASH_IT="/Users/john_otwell/.bash_it"
    export BASH_IT_THEME="bobby"

    alias et="emacsclient -nw"
    alias xc='pbcopy'
    alias bashbare='bash --noprofile --norc'
    alias gsv='git status -v'

    # cheatsheets
    # usage: `ch git~worktree` for tools`
    # usage: `ch go/:learn` for languages`
    # usage: `ch go/reverse+a+list` for languages`
    ch() {
      tmux split-window -h bash -c "curl cht.sh/$1 | less -r"
    }

    # fullscreen of the above
    chf() {
      curl cht.sh/$1~$2 | less -r
    }

    eval "$(thefuck --alias)"

    set -o vi

    if command -v fzf-share >/dev/null; then
      source "$(fzf-share)/key-bindings.bash"
      source "$(fzf-share)/completion.bash"
    fi

    eval "$(/opt/homebrew/bin/brew shellenv)"
    source ~/code/scripts/do-the-thing.sh
    source ~/code/scripts/nvm.sh
    source "$BASH_IT"/bash_it.sh'';
  home.file.".bash_it".source = myBashIt;
}
