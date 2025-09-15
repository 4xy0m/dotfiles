if [ -f flake.nix ]; then
  if ! nix develop -c $1; then
    clear
    $1
  fi
else 
  $1
fi
