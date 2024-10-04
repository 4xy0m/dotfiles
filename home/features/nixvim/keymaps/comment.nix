{...}: {
  programs.nixvim.keymaps = [
    {
      key = "<leader>/";
      action = "gcc";
      mode = ["n"];
    }
    {
      key = "<leader>/";
      action = "gc";
      mode = ["v"];
    }
  ];
}
