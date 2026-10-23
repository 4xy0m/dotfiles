{ ... }: {
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
        settings = {
          main = {
            capslock = "overload(arrows, esc)";
          };
          arrows = {
            n = "left";
            e = "down";
            i = "up";
            o = "right";
          };
        };
      };
    };
  };
}
