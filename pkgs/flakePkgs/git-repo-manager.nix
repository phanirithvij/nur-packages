{
  system ? "x86_64-linux",
}:
let
  f = builtins.getFlake "github:hakoerber/git-repo-manager/fd5cd60c1dc9c225d7851fe935a7bdbafb268d69";
in
f.packages.${system}.default
