{ config, pkgs, ... }:

{
  imports =
    [
      ../services/ssh.nix
      ../services/ntp.nix
      ../services/neovim.nix
      ../services/nix.nix
      ../modules/users.nix
    ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_CA.UTF-8";
  };

  time.timeZone = "America/Toronto";

  # install basic packages
  environment.systemPackages = with pkgs; [
    curl
    file
    gitAndTools.gitFull
    htop
    jq
    jwhois
    lshw
    lsof
    mercurial
    mtr
    netcat-gnu
    pwgen
    rsync
    silver-searcher
    sshfs
    strace
    tcpdump
    telnet
    tig
    tree
    unzip
    wget
    whois
    zip
  ];

  programs.bash.enableCompletion = true;
  programs.zsh.enable = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [ "git" "systemd" "colorize" "colored-man-pages" ]; 
  programs.zsh.ohMyZsh.theme = "agnoster";
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.shellAliases =  	{
    l = "ls -alh";
    ll = "ls -l";
    ls = "ls --color=tty";
    vi = "vim";
  };

  programs.tmux.enable = true;
  programs.tmux.clock24 = true;
  programs.tmux.terminal = "screen-256color";
  programs.tmux.extraTmuxConf = ''
    # hh
  '';
  # copy the system configuration into nix-store
  system.copySystemConfiguration = true;
  security.sudo.wheelNeedsPassword = false;
}
