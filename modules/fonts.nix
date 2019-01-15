{ pkgs, unstable, ... }:

{

  fonts.fonts = with pkgs; [
    cantarell_fonts
    corefonts
    dejavu_fonts
    fira-code
    fira-code-symbols
    font-awesome-ttf
    hack-font
    noto-fonts
    unstable.weather-icons
  ];

}
