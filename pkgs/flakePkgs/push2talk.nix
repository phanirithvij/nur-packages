{
  stdenv,
}:
let
  f = builtins.getFlake "github:cyrinux/push2talk/1a87e17bb1af5bc115e3b46979903b2daaf873af";
in
f.defaultPackage.${stdenv.hostPlatform.system}
