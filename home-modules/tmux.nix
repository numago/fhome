# https://github.com/nix-community/home-manager/blob/master/modules/programs/tmux.nix
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # https://github.com/joshmedeski/sesh
    sesh # tmux session manager
  ];

  programs.tmux = {
    # https://mynixos.com/nixpkgs/options/programs.tmux
    # https://github.com/tmux-plugins/tmux-continuum?tab=readme-ov-file
    # https://github.com/tmux-plugins/tmux-resurrect
    # https://github.com/srid/nixos-config/blob/master/home/tmux.nix
    enable = true;
    newSession = false; # edited
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    escapeTime = 0;
    historyLimit = 5000;
    keyMode = "vi";
    shortcut = "space";

    plugins = with pkgs.tmuxPlugins; [

      # PERF: extrakto can do what fzf-tmux-url can.
      {
        # Extract urls
        plugin = fzf-tmux-url;
        extraConfig = "set -g @fzf-url-bind 'u'";
      }

      extrakto # Extract text (default: prefix + Tab)

      tmux-fzf # Tmux command selector in fzf (default: prefix + F)

      # {
      #   # Continuous saving and restoring of tmux environment
      #   plugin = continuum;
      #   extraConfig = ''
      #     set -g @continuum-restore 'on'
      #     set -g @continuum-save-interval '10'
      #   '';
      # }

      {
        # Setting keybingings for cross navigation between neovim windows and tmux panes 
        # Using alexghergh/nvim-tmux-navigation plugin on the nvim side
        # Note: plugin will override Ctrl+l
        plugin = vim-tmux-navigator;
        extraConfig = ''
          set -g @plugin 'christoomey/vim-tmux-navigator'
        '';
      }

      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          # set -g @resurrect-capture-pane-contents 'on'
        '';
      }
    ];
    extraConfig = builtins.readFile ../config/tmux/tmux.conf;
  };
}
