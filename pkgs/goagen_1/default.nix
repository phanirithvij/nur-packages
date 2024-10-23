# https://github.com/NixOS/nixpkgs/issues/318069
{
  lib,
  fetchFromGitHub,
  buildGoModule,
}:
buildGoModule rec {
  pname = "goagen";
  version = "1.4.3";

  src = fetchFromGitHub {
    owner = "goadesign";
    repo = "goa";
    rev = "refs/tags/v${version}";
    hash = "sha256-9sJZf3FO83n7LZScLy6ZC12o5+t3MNSCzWBSu6O9aeg=";
  };

  patches = [ ./goagen-go-mod.patch ];

  vendorHash = "sha256-mhZWmE8R9ss391PVzHElxz5Kp0zoT1nv+Zrlh3PThWE=";
  proxyVendor = true; # ??

  subPackages = [ "goagen" ]; # ?? fails at runtime

  doCheck = false; # fails

  postBuild = ''
    mkdir -p $out/share/src
    cp -r . $out/share/src
  '';

  meta = {
    description = "goagen v1.4.3";
    homepage = "https://github.com/goadesign/goa/tree/v1";
    license = lib.licenses.mit;
    mainProgram = "goagen";
  };
}
