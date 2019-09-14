{ ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins =
        [ "git"
          "pass"
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
      wp = "j";
    };
  };
}
