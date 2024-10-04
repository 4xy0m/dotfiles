{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
    ];
    initExtra = ''
      eval "$(starship init zsh)"
      eval "$(fzf --zsh)"
      zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
      ZVM_INIT_MODE=sourcing
    '';
  };
}
