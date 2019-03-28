{ pkgs, ... }:
let
  xdg_abook = pkgs.abook.overrideDerivation (oldAttrs: {
    patches = oldAttrs.patches ++ [ ./abook-xdg.diff ];
  });
in
{
  services.nullmailer = {
    enable = true;
    # the format is
    # smtp.gmail.com smtp --port=465 --auth-login --ssl --insecure --user=user@domain.com --pass=pass
    remotesFile = "/home/rail/.config/nullmailer.remotes";
  };

  environment.systemPackages = with pkgs; [
    xdg_abook
    aspell
    aspellDicts.en
    lynx
    neomutt
    offlineimap
    urlview
    notmuch
  ];
}
