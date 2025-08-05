{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:hakoerber/git-repo-manager/9a46df42e52ca159d72f7da439bc51949b004afc";
in
f.packages.${system}.default
