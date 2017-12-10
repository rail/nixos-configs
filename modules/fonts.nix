{ config, pkgs, ... }:

{

  fonts.fonts = with pkgs; [
    anonymousPro
    cantarell_fonts
    dejavu_fonts
    fira
    fira-code
    fira-code-symbols
    fira-mono
    font-awesome-ttf
    hack-font
    noto-fonts
    source-code-pro
  ];

}
