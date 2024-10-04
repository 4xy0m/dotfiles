{inputs, ...}: {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  age.identityPaths = ["/home/nixos/.ssh/id_ed25519"];
  age.secrets.spotify.file = ../../secrets/spotify.age;
}
