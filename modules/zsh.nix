{ ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "systemd" "colorize" "colored-man-pages" "virtualenvwrapper" ];
      theme = "frisk";
    };
    shellAliases = {
      l = "ls -alh";
      ll = "ls -l";
      ls = "ls --color=tty";
      vi = "vim";
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
      setopt NOCLOBBER
      setopt no_nomatch # when pattern matching fails, simply use the command as is
    '';
  };
}
