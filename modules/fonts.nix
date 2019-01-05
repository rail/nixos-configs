{ pkgs, unstable, ... }:

let
  nerd-fonts-source-code-pro = pkgs.nerdfonts.override {
    withFont = "SourceCodePro";
  };

in

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
    nerd-fonts-source-code-pro
    unstable.weather-icons
  ];

}
