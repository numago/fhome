{ pkgs, lib, ... }:

{
  home.packages = [
    #   # (pkgs.nerdfonts.override {
    #   #   fonts = [ "Cousine" "Iosevka" "CascadiaCode" ];
    #   # })
    pkgs.nerd-fonts.cousine
    pkgs.nerd-fonts.iosevka
    # pkgs.nerd-fonts.cascadia-code
  ];

  # Allow effective font management
  fonts = {
    fontconfig.enable = true;
    # packages = [
    #   pkgs.nerd-fonts.cousine
    #   pkgs.nerd-fonts.iosevka
    #   # pkgs.nerd-fonts.cascadia-code
    # ];
  };
}

