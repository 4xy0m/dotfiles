{
  config,
  pkgs,
  ...
}: {
  programs.tmux = with config.colorScheme.palette; {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    prefix = "C-Space";
    keyMode = "vi";
    extraConfig = ''
      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind -r -n C-S-h resize-pane -L
      bind -r -n C-S-l resize-pane -R
      bind -r -n C-S-j resize-pane -D
      bind -r -n C-S-k resize-pane -U

      set-option -g default-terminal "screen-256color"
      set-option -g status-position bottom

      bind Tab next-window
      bind g display-popup -E "lazygit"
    '';
    plugins = with pkgs; [
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
    ];
  };
}
