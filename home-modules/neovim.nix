{ pkgs, lib, ... }:

{
  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        lazy-nvim
      ];
    };
  };

  home.file.".config/nvim" = {
    source = ../config/nvim;
    recursive = true; # Allows lazy-vim to write to .config/nvim/
  };
}
