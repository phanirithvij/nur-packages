{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchYarnDeps,
  yarnConfigHook,
  yarnBuildHook,
  yarnInstallHook,
  buildNpmPackage,
  nodejs,
}:
let
  src = fetchFromGitHub {
    owner = "pomber";
    repo = "git-history";
    rev = "a20f6085cf9055b350a4db13cea6e013936da9cd";
    hash = "sha256-5JV0NuVi+jzS0mhi5ORfpoFZ/sFOW42YIwMLn5pXTrw=";
    postFetch = "rm -f $out/src/demo.mp4 $out/src/demo.webm";
  };
  pname = "git-history";
  version = "1.0.1-unstable-2024-10-10";
  jslib = stdenv.mkDerivation {
    inherit src pname version;
    yarnOfflineCache = fetchYarnDeps {
      yarnLock = src + "/yarn.lock";
      hash = "sha256-75CfFfNaxHR0yafnV+jfLfXHUsm2COr+zpxQHPu0+iU=";
    };
    patches = [ ./jslib.patch ];
    NODE_OPTIONS = "--openssl-legacy-provider";
    nativeBuildInputs = [
      yarnConfigHook
      yarnBuildHook
      yarnInstallHook
      nodejs
    ];
    postInstall = "cp -r build $out";
  };
  jslibCli = jslib.overrideAttrs {
    env.REACT_APP_GIT_PROVIDER = "cli";
    env.GENERATE_SOURCEMAP = false;
    env.NODE_ENV = "production";
  };
in
buildNpmPackage {
  inherit src pname version;
  sourceRoot = "${src.name}/cli";
  patches = [ ./cli.patch ];
  npmDepsHash = "sha256-IlN0zZwvS1IBJmFFCdR7JxVcuy/Qe2U/Jr11226xPsA=";
  preBuild = "cp -r ${jslibCli}/build/ site/";
  dontFixup = true;
  # TODO vscode ext
  passthru = { inherit jslib; };
  meta = {
    description = "Quickly browse the history of a file from any git repository";
    homepage = "https://github.com/pomber/git-history";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "git-history";
    platforms = lib.platforms.all;
  };
}
