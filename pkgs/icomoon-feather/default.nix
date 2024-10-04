{fetchurl}: let
  pname = "Icomoon-Feather";
  version = "c75286d29076923859ac40e604c1821d666ccf55";
in
  fetchurl {
    name = "${pname}-${version}";
    url = "https://github.com/adi1090x/rofi/raw/${version}/fonts/${pname}.ttf";

    downloadToTemp = true;
    recursiveHash = true;

    postFetch = ''
      mkdir -p $out/share/fonts/truetype
      install -D $downloadedFile $out/share/fonts/truetype/${pname}.ttf
    '';

    sha256 = "sha256-sNC/0MyGJ0G+qx/qhbM0561eqsIrZ7Gr9zXzJqdqSa0=";
  }
