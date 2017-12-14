{ config, pkgs, ... }:

{
  services.postfix.enable = true;
  services.postfix.relayHost = "[smtp.gmail.com]:587";
  services.postfix.extraConfig = ''
    smtp_sasl_auth_enable = yes
    smtp_use_tls = yes
    smtp_sasl_security_options =
    # smtp_sasl_password_maps = hash:/etc/postfix/relay_passwd
    # smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt
    message_size_limit = 20480000
  '';
  environment.systemPackages = with pkgs; [
    abook
    aspell
    aspellDicts.en
    lynx
    mutt
    offlineimap
    urlview
    # aspell
  ];
}
