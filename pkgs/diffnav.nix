# nix-init, behold
{
  lib,
  buildGo123Module,
  fetchFromGitHub,
}:

buildGo123Module rec {
  pname = "diffnav";
  version = "0.2.8";

  src = fetchFromGitHub {
    owner = "dlvhdr";
    repo = "diffnav";
    rev = "v${version}";
    hash = "sha256-xZAi/Ky1RjOxjhQKHvozaPTqDPcrGfhMemGWzi7WyW4=";
  };

  vendorHash = "sha256-2JjQF+fwl8+Xoq9T3jCvngRAOa3935zpi9qbF4w4hEI=";

  ldflags = [ "-s" ];

  meta = {
    description = "A git diff pager based on delta but with a file tree, à la GitHub";
    homepage = "https://github.com/dlvhdr/diffnav";
    license = lib.licenses.mit;
    mainProgram = "diffnav";
  };
}
