{ pkgs, config, ... }:

# https://github.com/nix-community/home-manager/tree/master/modules
{
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.username = "unknown";

  home.homeDirectory = "/home/unknown";

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.cargo/bin"
    "$HOME/.ghcup/bin" # temporary, because ghcup nix package is broken
  ];

  # Setup my scripts
  home.file."bin".source = ./bin;

  nixGL.packages = import <nixgl> { inherit pkgs; };
  nixGL.defaultWrapper = "mesa";
  nixGL.offloadWrapper = "nvidiaPrime";

  nixGL.installScripts = [ "mesa" "nvidiaPrime" ];
  home.packages = with pkgs; [
    go
    lua
    sqlite
    cargo
    gcc
    bun
    docker
    gh # Github CLI
    lazygit # TUI for git commands
    ffmpeg_6
    libsecret # Gnome libsecret
    btop # Resource manager TUI
    gdu # Disk usage analyzer CLI
    cudaPackages.cudatoolkit
    texlive.combined.scheme-small
    whois
    sshfs


    mullvad-vpn # Client for Mullvad VPN
    mullvad-browser
    bitwarden
    vlc
    thunderbird
    telegram-desktop
    libreoffice
    fx # Terminal JSON viewer
    virtualbox
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
    ];
  };

  # set up symlink for dockerd
  # sudo ln -s $(which dockerd) /usr/bin/dockerd

  # Btop tokyo night theme
  home.file.".config/btop/btop.conf" = {
    source = ./config/btop/btop.conf;
  };

  xdg = {
    enable = true;
    mimeApps = {
      associations.added = {
        "application/pdf" = "zathura.desktop";
      };
    };
    desktopEntries = {
      zathura = {
        name = "Zathura";
        genericName = "PDF Viewer";
        exec = "zathura %U";
        terminal = false;
        # categories = [ "Application" "Network" "WebBrowser" ];
        mimeType = [ "application/pdf" ];
      };
    };
  };

  imports = [
    ./home-modules
  ];

  # Better compatibility for non-NixOS Linux systems (including setting XDG_DATA_DIRS)
  targets.genericLinux.enable = true;

  nix.package = pkgs.nix; # Dont use flakes for now (pkgs.nixFlakes)
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
