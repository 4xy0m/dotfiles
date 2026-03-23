{ inputs, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
    settings = {
      theme = "system";
      plugin = [
        "opencode-claude-auth"
        "oh-my-opencode-slim@latest"
      ];
    };
  };
}
