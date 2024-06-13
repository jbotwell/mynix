{inputs, ...}: {
  home.file.".bash_it".source = inputs.my-bash-it;
  programs.bash = {
    enable = true;
    shellAliases = {
      gsv = "git status -v";
    };
    sessionVariables = {
      BASH_IT = "/Users/john_otwell/.bash_it";
      BASH_IT_THEME = "bobby";
      FLAKE = "/Users/john_otwell/code/mynix";
      EDITOR = "vim";
      PATH = "$PATH:/opt/homebrew/bin:/Users/john_otwell/Library/Python/3.9/bin";
      OPENAI_API_KEY = "$(pass big-oai)";
      AZURE_API_KEY = "$(pass oai-new)";
      AZURE_API_VERSION = "2023-05-15";
      AZURE_API_BASE = "$(pass oai-endpoint)";
      OPENROUTER_API_KEY = "$(pass openrouter-api-key)";
      ANTHROPIC_API_KEY = "$(pass anthropic-appi-key)";
      PPLX_API_KEY = "$(pass perplexity-api-key)";
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
