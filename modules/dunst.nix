{ pkgs, lib, ... }:

let
  themePackage = pkgs.gnome3.adwaita-icon-theme;
  themeDir = "Adwaita";
  categories = [
    "actions"
    "animations"
    "apps"
    "categories"
    "devices"
    "emblems"
    "emotes"
    "filesystem"
    "intl"
    "mimetypes"
    "places"
    "status"
    "stock"
  ];
  iconPath = lib.concatStringsSep ":" (
    map (category: "${themePackage}/share/icons/${themeDir}/32x32/${category}") categories);
  dunstConfig = pkgs.writeText "dunstrc" ''

    [global]
        font = Cantarell 12
        markup = yes
        format = "<b>%s</b>\n%b %p"
        sort = yes
        indicate_hidden = yes
        alignment = left
        bounce_freq = 0
        show_age_threshold = 60
        word_wrap = yes
        ignore_newline = no
        geometry = "300x5-10+45"
        shrink = no
        transparency = 10
        idle_threshold = 120
        monitor = 0
        follow = keyboard
        sticky_history = yes
        history_length = 20
        show_indicators = yes
        line_height = 0
        separator_height = 2
        padding = 8
        horizontal_padding = 8
        separator_color = auto
        startup_notification = false
        max_icon_size = 32
        icon_position = left

        # Paths to default icons.
        icon_path = ${iconPath}

        frame_width = 2
        frame_color = "#aaaaaa"

    [shortcuts]
        close = mod4+slash
        close_all = mod4+shift+slash
        history = mod4+grave

    [urgency_low]
        background = "#101010"
        foreground = "#dedede"

    [urgency_normal]
        background = "#101010"
        foreground = "#dedede"

    [urgency_critical]
        background = "#101010"
        foreground = "#cc0000"
  '';
in
{
  systemd.user.services.dunst = {
    description = "Dunst notification daemon";
    after = [ "graphical-session-pre.target" ];
    partOf = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.dunst}/bin/dunst -config ${dunstConfig}";
      PassEnvironment = "DISPLAY";
    };
  };
}
