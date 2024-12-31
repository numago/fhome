# https://github.com/nix-community/home-manager/blob/master/modules/programs/zsh.nix
{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins"; # vi keybindings
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    history = {
      extended = true;
      expireDuplicatesFirst = true;
      ignorePatterns = [ "cl" ];
    };

    shellAliases = {
      o = "xdg-open";
      q = "exit";
      e = "$EDITOR";
      g = "git";
      c = "bat --style changes";
      x = "clear";
      mvdl = "mv-latest-download.sh";
      cc = "copy-context.sh";
      clip = "xclip -selection clipboard -i";
      pilc = "xclip clipboard -out";
      math = "bc --mathlib --quiet";
      ll = "eza --long --icons";
      la = "eza --long --all --all --octal-permissions --group --icons --git";
      lt = "eza --long --icons --sort=modified --color=always | tail -n 8";
      tree = "eza --tree";
      touchtype = "touchpad-typing-mode.gnome.sh";
      wl = "nmcli dev wifi rescan";
      pwc = "bitwarden-password-copy.sh";
      lg = "lazygit";
    };


    shellGlobalAliases = {
      G = "| grep --ignore-case --color=auto";
      C = "| clip";
      LAT = "$(latest-file.sh)";
    };

    dirHashes = { };

    localVariables = {
      # Ensures xdg desktop entries and other relevant data are accessible
      XDG_DATA_DIRS = "$HOME/.nix-profile/share:$XDG_DATA_DIRS";
      EDITOR = "nvim";
      VISUAL = "nvim";
      EZA_ICON_SPACING = "2";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "rbw" ];
    };

    initExtra = ''
      # source start-tmux.sh
      eval "$(thefuck --alias)"
      
      # Config for pkgs.z-lua
      eval "$(z --init zsh enhanced once)" 
      # eval "$(zoxide init zsh)"

      # In vim insert mode, set Ctrl-p to move cursor up history, like in normal mode
      bindkey -v '^P' up-line-or-history

      # In vim insert mode, set Ctrl-n to move cursor down history, like in normal mode
      bindkey -v '^N' down-line-or-history

      # For fzf-tab set 'tab' (default='/') keybinding for continuous-completion
      # zstyle ':fzf-tab:*' continuous-trigger 'tab'
       
      # Preview directory's content with eza when completing cd
      # zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    '';

    plugins = [
      # Lets you use zsh as the default shell in a nix-shell environment
      # https://github.com/chisui/zsh-nix-shell
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.5.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
      # Replaces zsh's default completion selection menu with fzf
      # https://github.com/Aloxaf/fzf-tab
      {
        name = "zsh-fzf-tab";
        file = "fzf-tab.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "3aa44739958691c4de06496e5bb18e0a629edd6d";
          sha256 = "sha256-VK+qJsyo0rQ2FV6lzUPhGTYNznHCuu4eOCcREqaD8jQ=";
        };
      }
    ];
  };
}

