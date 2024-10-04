let
  user1 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM3Qre7eo3uNBV34msVe1CqR1JUFzyD+86wt0AFPBuVe";
  user2 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC6MvljrHvNcZZDFDZN6ySi3z3qSE9WcV7EApTxdh/aJ";
  users = [user1 user2];
in {
  "spotify.age".publicKeys = users;
}
