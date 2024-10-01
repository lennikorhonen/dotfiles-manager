{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    prefix = "C-Space";
    terminal = "screen-256color";
    keyMode = "vi";
    clock24 = true;
    escapeTime = 0;
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set-environment -g COLORTERM "truecolor"

      set-option -g mouse on
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
