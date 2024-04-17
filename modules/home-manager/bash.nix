{ pkgs, ... }:
let
  # TODO - use flakes
  myBashIt = pkgs.fetchFromGitHub {
    owner = "jbotwell";
    repo = "my_bash_it";
    rev = "main";
    sha256 = "0dp5qhlvi7z6rr5jp0b1s6ri0azhskv8n5w2d4ammrwcm5rphcrq";
  };
in {
  home.file.".bash_it".source = myBashIt;
  programs.bash = {
    enable = true;
    shellAliases = {
      et = "emacsclient -nw";
      xc = "xclip -sel clip";
      bashbare = "bash --noprofile --norc";
      gsv = "git status -v";
      mini = "export TERM=ansi && ssh john@mini";
      nixfmtall = "find ~/code/mynix -type f -print0 | xargs -0 nixfmt";
      manf = "manix \"\" | grep '^# ' | sed 's/^# \(.*\) (.*/\1/;s/ (.*//;s/^# //' | fzf --preview=\"manix '{}'\" | xargs manix";
    };
    sessionVariables = {
      BASH_IT = "/home/john/.bash_it";
      BASH_IT_THEME = "bobby";
    };
    initExtra = ''
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

      PATH=$PATH:$HOME/.local/bin

      set -o vi

      source "$BASH_IT"/bash_it.sh'';
  };
}
