{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    zsh-powerlevel9k
  ];

  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [ "git" "systemd" "colorize" "colored-man-pages" ];
  programs.zsh.ohMyZsh.theme = "frisk";
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.shellAliases = {
    l = "ls -alh";
    ll = "ls -l";
    ls = "ls --color=tty";
    vi = "vim";
  };
  programs.zsh.interactiveShellInit = ''
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

}
