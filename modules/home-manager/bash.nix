{
  inputs,
  pkgs,
  ...
}: {
  home.file.".bash_it".source = inputs.my-bash-it;

  home.packages = with pkgs; [
    thefuck
  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      bashbare = "bash --noprofile --norc";
      gsv = "git status -v";
      manf = ''manix "" | grep '^# ' | sed 's/^# (.*) (.*/1/;s/ (.*//;s/^# //' | fzf --preview="manix '{}'" | xargs manix'';
      mini = "export TERM=ansi && ssh john@mini";
      nixfmtall = "find ~/code/mynix -type f -print0 | xargs -0 alejandra";
      pu = ''protonup -d "~/.steam/root/compatibilitytools.d/"'';
      pywhis = "nix run github:jbotwell/pywhis";
      xc = "xclip -sel clip";
    };

    sessionVariables = {
      ANTHROPIC_API_KEY = "$(cat /run/secrets/anthropic_key)";
      BASH_IT = "/home/john/.bash_it";
      BASH_IT_THEME = "bobby";
      EDITOR = "vim";
      FLAKE = "/home/john/code/mynix";
      OPENAI_API_KEY = "$(cat /run/secrets/openai_key)";
      OPENROUTER_API_KEY = "$(cat /run/secrets/openrouter_key)";
      PATH = "$PATH:$HOME/.local/bin";
      PPLX_API_KEY = "$(cat /run/secrets/pplx_key)";
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
