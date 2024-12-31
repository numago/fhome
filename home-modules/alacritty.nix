{ pkgs, config, ... }:

{
  home.file.".config/alacritty/alacritty.toml".source = ../config/alacritty.toml;

  programs.alacritty = {
    enable = true;
    # settings = builtins.readFile ../config/alacritty.toml;
    # configFile = "$HOME/config/alacritty.yml";
    package = config.lib.nixGL.wrap pkgs.alacritty;
  };
}
