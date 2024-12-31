{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./starship.nix
    ../alacritty.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    z-lua
    zoxide
    bat # 'cat' alternative
    fd # 'find' alternative
    ripgrep # 'grep' alternative
    duf # 'df' alternative - reporting disk space usage
    eza # 'ls' alternative - listing directory content
    glow # Terminal markdown renderer
    fzf # Command-line Fuzzy find 
    rbw # Unofficial Bitwarden client CLI
    thefuck # Corrects errors in previous commands
    diff-so-fancy # Improved human readable diffs
    # kitty
    # glfw
    # glew
    # glm
    # glui
    # libGL
    # libGLU
  ];

  programs.kitty = {
    enable = true;
  };


  home.sessionVariables = { };

  home.file.".config/bat".source = ../../config/bat;
}

