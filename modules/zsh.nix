{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    exa
  ];
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
      l = "exa -alh";
      ll = "exa -l";
      ls = "exa";
      scp =" scp -rC";
      wp = "j";
    };
  };
}
