{pkgs, ...}: {
  home.packages = with pkgs; [
    # rust
    cargo
    rustc
    rustfmt

    redis

    # python
    python3
    poetry
  ];
}
