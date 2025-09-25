{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:hakoerber/git-repo-manager/fe182353ec868a35b2cd4d043d8f0365df6237e2";
in
f.packages.${system}.default
