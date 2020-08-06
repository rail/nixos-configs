{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-20.03.tar.gz;
  oceanicnext = builtins.readFile (pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/pinpox/base16-xresources/master/xresources/base16-oceanicnext-256.Xresources";
    sha256 = "0rdxsxf30sw2q1nm5mcjf4avgdlj4n0apjblh05dlp3an7ya3ibn";
  });
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
      extraConfig = oceanicnext;
    };

    services.network-manager-applet.enable = true;

    services.blueman-applet.enable = true;
    services.cbatticon = {
      enable = true;
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
