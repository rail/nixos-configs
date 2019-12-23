{ pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/rycee/home-manager/archive/release-19.09.tar.gz;
in
{
  imports = [ "${home-manager}/nixos" ];
  home-manager.users.rail = {

    home.file = {
      # ".Xresources".source = ./dotfiles/.Xresources;
      ".zshrc".source = ./dotfiles/.zshrc;
      ".tmux.conf".source = ./dotfiles/.tmux.conf;

      "bin" = {
        source = ./dotfiles/bin;
        recursive = true;
      };

      ".config" = {
        source = ./dotfiles/config;
        recursive = true;
      };

    };
    xresources.properties = {
      "Xft.dpi" = 144;
      "Xcursor.size" = 48;
    };
    xresources.extraConfig =  builtins.readFile (
      pkgs.fetchFromGitHub {
        owner = "material-ocean";
        repo = "Material-Ocean";
        rev = "8a17b374031110e4e3f3e98750a88d4ed38341ad";
        sha256 = "0as0826zzf9pcdrckbryn82jnw268chys1c75pxpxj1r5if9im6z";
      } + "/.Xresources"
    );

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
