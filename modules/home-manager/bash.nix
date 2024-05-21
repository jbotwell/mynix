{inputs, ...}: {
  home.file.".bash_it".source = inputs.my-bash-it;
  programs.bash = {
    enable = true;
    shellAliases = {
      et = "emacsclient -nw";
      xc = "xclip -sel clip";
      bashbare = "bash --noprofile --norc";
      gsv = "git status -v";
      mini = "export TERM=ansi && ssh john@mini";
      nixfmtall = "find ~/code/mynix -type f -print0 | xargs -0 alejandra";
      manf = ''
        manix "" | grep '^# ' | sed 's/^# (.*) (.*/1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" | xargs manix'';
    };
    sessionVariables = {
      BASH_IT = "/home/john/.bash_it";
      BASH_IT_THEME = "bobby";
      FLAKE = "/home/john/code/mynix";
      PATH = "$PATH:$HOME/.local/bin:$HOME/.config/emacs/bin";
      OPENAI_API_KEY = "$(pass openai)";
      OPENROUTER_API_KEY = "$(pass openrouter)";
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

      set -o vi

      source "$BASH_IT"/bash_it.sh
    '';
  };
}
