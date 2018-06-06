{ pkgs, ... }:

let
  nerd-fonts-source-code-pro = pkgs.nerdfonts.override {
    withFont = "SourceCodePro";
  };

in

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
    nerd-fonts-source-code-pro
    dejavu_fonts
    liberation_ttf
    roboto-mono
    ttf_bitstream_vera
    ubuntu_font_family
  ];

}
