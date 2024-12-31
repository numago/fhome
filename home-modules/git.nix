{ pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status";
      unstage = "restore --staged";
      del = "branch -D";
      what = "log --branches --format=\"%C(auto)%d %Cblue%cr%Creset %C(auto)%s\" --decorate --date=relative";
      rehead = "restore --source=HEAD -- ";
    };
    extraConfig = {
      # "diff.tool" = "your-difftool-name";
      # "difftool.your-difftool-name.cmd" = "your-difftool-command \"$LOCAL\" \"$REMOTE\"";
    };
  };

  # uses diff-so-fancy package
  home.file.".config/lazygit" = {
    source = ../config/lazygit;
    recursive = true; # Allows lazy-git to write to .config/lazygit/
  };
}


