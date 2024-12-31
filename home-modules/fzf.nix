{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd . -L -t f";
    defaultOptions = [
      "--bind='ctrl-d:reload(fd . -t d),ctrl-f:reload(eval \"$FZF_DEFAULT_COMMAND\")'"
      "--height=10%"
      "--layout=reverse"
    ];

    tmux = {
      #enableShellIntegration = false;
      #shellIntegrationOptions = [
      #"--layout=reverse"
      #];
    };

    # ALT-C command - cd into the selected directory
    changeDirWidgetCommand =
      "fd . -L -t d --color never --hidden "
      + "--exclude '/sys' --exclude '/dev' --exclude '/proc' --exclude '/run' "
      + "--exclude '$HOME/.local/share/Trash'";

    # CRTL-R command - Paste the selected command from history onto the command-line
    historyWidgetOptions = [
      "--preview 'echo {}' --preview-window up:3:hidden:wrap"
      "--bind 'ctrl-/:toggle-preview'"
      "--bind 'ctrl-y:execute-silent(echo -n {2..} | clip)+abort'"
      "--color header:italic"
      "--header ''"
    ];

    # tokyonight themed
    colors = {
      fg = "#c0caf5";
      bg = "#1a1b26";
      hl = "#bb9af7";
      "fg+" = "#c0caf5";
      "bg+" = "#2f334d";
      "hl+" = "#7dcfff";
      info = "#7aa2f7";
      prompt = "#ec7279";
      pointer = "#7dcfff";
      marker = "#9ece6a";
      spinner = "#ec7279";
      header = "#9ece6a";
    };
  };
}
