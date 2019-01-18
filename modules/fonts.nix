{ pkgs, unstable, ... }:

{

  fonts.fonts = with pkgs; [
    anonymousPro
    cantarell_fonts
    corefonts
    dejavu_fonts
    fira-code
    fira-code-symbols
    font-awesome-ttf
    font-awesome_5
    freefont_ttf
    hack-font
    liberation_ttf
    material-icons
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    powerline-fonts
    source-code-pro
    unstable.weather-icons
  ];

}
