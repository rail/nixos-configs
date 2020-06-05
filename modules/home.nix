{ pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-20.03.tar.gz;
  base16-scheme = "oceanicnext";
  base16 = pkgs.stdenv.mkDerivation {
    name = "base16-builder";
    src = builtins.fetchTarball {
      url = "https://github.com/auduchinok/base16-builder/archive/51e3ad4d447fc3f1f539d0bfe33c851728fb6b5f.tar.gz";
      sha256 = "1qir689h38c6jr7fbbqbc3029544zgv41lrrqdcq26kcwxcwjrz1";
    };
    nativeBuildInputs = [pkgs.ruby];
    buildPhase = "${pkgs.ruby}/bin/ruby base16 -s schemes/${base16-scheme}.yml";
    installPhase = ''
      mkdir -p $out
      cp -r output/* $out
    '';
  };
  xresources = "${base16}/xresources/base16-${base16-scheme}.dark.256.xresources";
in
{
  imports = [ "${home-manager}/nixos" ];
  home-manager.users.rail = {

    home.file = {
      ".zshrc".source = ./dotfiles/zshrc;
      ".tmux.conf".source = ./dotfiles/tmux.conf;

      "bin" = {
        source = ./dotfiles/bin;
        recursive = true;
      };

      ".config" = {
        source = ./dotfiles/config;
        recursive = true;
      };
      ".xmonad/xmonad.hs".source = ./dotfiles/xmonad/xmonad.hs;

    };

    xresources.properties = {
      "Xft.dpi" = 144;
      "Xcursor.size" = 48;
      extraConfig = builtins.readFile xresources;
    };

    services.network-manager-applet.enable = true;

    services.blueman-applet.enable = true;
    services.cbatticon = {
      enable = true;
      commandCriticalLevel = ''
        notify-send "LOW BATTERY"
      '';
      criticalLevelPercent = 15;
    };

    services.dunst = {
      enable = true;
      settings = {
        global = {
          geometry = "600x5-30+50";
          transparency = 10;
          font = "Cantarell 12";
          follow = "keyboard";
          markup = "yes";
          idle_threshold = 120;
          word_wrap = "yes";
          monitor = 0;
          frame_color = "#aaaaaa";
          frame_width = 2;
          sort = "yes";
          separator_color = "auto";
          separator_height = 2;
          padding = 8;
          horizontal_padding = 8;
          sticky_history = "yes";
          history_length = 20;
          show_indicators = "yes";
          icon_position = "left";
        };

        urgency_normal = {
          background = "#101010";
          foreground = "#dedede";
        };
        urgency_low = {
          background = "#101010";
          foreground = "#dedede";
        };
        urgency_critical = {
          background = "#101010";
          foreground = "#cc0000";
        };

      };
    };

  };
}
