{ pkgs, ... }:

{
  services.nullmailer = {
    enable = true;
    # the format is 
    # smtp.gmail.com smtp --port=465 --auth-login --ssl --insecure --user=user@domain.com --pass=pass
    remotesFile = "/home/rail/.config/nullmailer.remotes";
  };

  environment.systemPackages = with pkgs; [
    abook
    aspell
    aspellDicts.en
    lynx
    neomutt
    offlineimap
    urlview
    notmuch
  ];
}
