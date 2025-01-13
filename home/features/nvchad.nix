{ 
  inputs, 
  pkgs, 
  ... 
}: {
  programs.nvchad = {
    enable = true;
    extraPackages = with pkgs; [
      vscode-langservers-extracted
      nixd
      lua-language-server
      rust-analyzer
      nodePackages.graphql-language-service-cli
      nodePackages.svelte-language-server
      nodePackages.typescript-language-server
      taplo
      jdt-language-server
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        flake8
        autopep8
      ]))
    ];
    hm-activation = true;
    backup = true;
  };
}
