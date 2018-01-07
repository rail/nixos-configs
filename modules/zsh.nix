{ config, pkgs, ... }:

let

  # TODO: remove the following custom package in version next to 17.09
  zsh-powerlevel9k = pkgs.callPackage ../packages/zsh-powerlevel9k { };

in

{

  environment.systemPackages = with pkgs; [
    zsh-powerlevel9k
  ];

  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [ "git" "systemd" "colorize" "colored-man-pages" ];
  # programs.zsh.ohMyZsh.theme = "agnoster";
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

    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv root_indicator time)
    POWERLEVEL9K_MODE='nerdfont-complete'
    POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
    POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
    POWERLEVEL9K_SHOW_CHANGESET=true
    source ${zsh-powerlevel9k}/share/zsh-powerlevel9k/powerlevel9k.zsh-theme

  '';

}
