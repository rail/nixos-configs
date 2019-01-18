{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins =
        [ "git"
          "systemd"
          "pass"
          "colorize"
          "colored-man-pages"
          "virtualenvwrapper" 
        ];
      theme = "frisk";
    };
    shellAliases = {
      l = "ls -alh";
      ll = "ls -l";
      ls = "ls --color=tty";
      scp =" scp -rC";
      tmux = "tmux -2";
      mutt = "TERM=screen-256color mutt";
    };
    interactiveShellInit = ''
      setopt print_exit_value
      unsetopt share_history
      FIGNORE=".o:~"
      LISTMAX=0
      LOGCHECK=300
      MAILCHECK=0
      REPORTTIME=60

      zstyle :omz:plugins:ssh-agent agent-forwarding on
      zstyle :omz:plugins:ssh-agent lifetime 4h
      zstyle ':vcs_info:*' enable git
      setopt NOCLOBBER
      setopt no_nomatch # when pattern matching fails, simply use the command as is

      export BROWSER=firefox
      export WORKON_HOME=~/.virtualenvs

      function wp() {
          cd ~/work/git/$1;
      }
      _wp() {
          _files -W ~/work/git/
      }
      compdef _wp wp
    '';
  };
}
