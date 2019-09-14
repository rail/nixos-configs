{ ... }:

{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    clock24 = true;
    terminal = "screen-256color";
    baseIndex = 1;
    historyLimit = 10000;
    extraTmuxConf = ''
      unbind %
      bind - split-window -v
      unbind '"'
      bind | split-window -h

      set -g status-interval 5
      set -g status-bg black
      set -g status-fg white
      # set -g window-status-activity-bg default
      # set -g window-status-activity-fg default
      # set -g window-status-activity-attr underscore
      set -g status-left-length 30
      set -g status-right-length 60
      set -g status-left ' #[default]'
      set -g status-right '#[default]'
      setw -g window-status-format '#[fg=colour241]#I#F #[fg=white]#W#[default] '
      setw -g window-status-current-format '#[fg=colour241]#I#F #[bg=white,fg=black] #W #[bg=black,fg=white]'

      # ctrl+left/right cycles thru windows
      bind-key -n C-right next
      bind-key -n C-left prev

    '';
  };
}

