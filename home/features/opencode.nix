{ inputs, pkgs, ... }:
{
  programs.opencode = {
    enable = true;
    package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode;
    settings = {
      theme = "system";
      plugin = [
        "oh-my-opencode-slim"
      ];
    };
  };
}
