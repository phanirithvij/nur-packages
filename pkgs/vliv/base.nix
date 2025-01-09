{
  lib,
  fetchFromGitHub,
  pkgsCross,
  applyPatches,
  callPackage,

  # TODO debug arg, enable debug.dll
  debug ? false, # not needed if providing withPlugins?
  vliv, # self

# TODO base derivation
# then default package is minimal, which is internal plugin + source plugins except debug
# full package is all plugins including debug
# any other combination use withPlugins
}:
# TODO goal
# build from source, but how to build win32 binary on linux or macos, cross mingw?
# should run on linux! (confirmed wine with 32bit ver works)
#   64bit ver doesn't work with wine64 (WORKS with wineWowPackages.stableFull) (stableFull instead of stable because wine-mono comes pre-installed)
#      maybe just override stable/base/minimal to have embedInstallers = true;
#      unstable too, to test it out
#   so build 32bit ver of latest vliv and run via wine32 (wine) (not needed anymore)
# should be able to configure vlivplugins!
#   so vliv.withPlugins ( pp: with pp; [ tiff ... ] )?
#   plugins folder
# headers folder, so it can be used as a library
#   dev output? not likely just $out/devel?
#   https://github.com/delhoume/vlivinstaller/blob/main/vlivmui.nsi
# should run on windows (cross compiled .exe via nix)
# should run on macos wine (does normally according to author)
#   on macos it seems wineWowPackages.stableFull.meta.platforms doesn't work
#   maybe it works with wineWow64Packages.stableFull
#   maybe if I get 32bit latest ver it can work with macos old 32bit 13.0 macos with wine32
# nixostest for linux 32bit, 64bit binaries
#   cloudflared has some tests
#   drag drop test file in gui (possible?)
#   headers test by writing a simple hello world thing using vliv source code
# TODO WINEPREFIX
#   pkgs/by-name/sy/synthesia/package.nix
#   pkgs/by-name/vt/vtfedit/vtfedit.bash
# TODO makeDesktopItem
let
  # multiStdenv ??
  stdenv = pkgsCross.mingwW64.stdenv;
  pluginAttrs = callPackage ./plugins { inherit vliv; };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "vliv";
  version = "2.7.0";

  # TODO 32bit and 64bit bins in $out, with override args, only 64 enabled by default
  # or in all-packages provide vliv32 and vliv
  src = applyPatches {
    src = fetchFromGitHub {
      owner = "delhoume";
      repo = "vliv";
      tag = "v${finalAttrs.version}";
      hash = "sha256-Z1O7MwU8JGZCL+ocxMu2cTCTQuRnnNlpgNEb51+PyAw=";
    };
    patches = [ ./mingw-make.patch ];
  };
  sourceRoot = "${finalAttrs.src.name}/src";

  dontInstall = true;
  postBuild = ''
    mkdir -p $out/devel $out/bin
    echo -en plugins/*/* vliv.h | xargs -d' ' -I {} cp {} $out/devel
    mv vliv.exe $out/bin
    # TODO copy plugin dlls from respective derivations
    # withPlugins?
    # plugins path hardcoded in handlers.c RegisterPlugins
    # TODO Ownd.dll
  '';

  makeFlags = [
    "CC=${stdenv.cc.targetPrefix}cc"
    "RC=${stdenv.cc.targetPrefix}windres"
  ];

  passthru = {
    inherit (finalAttrs) version;
  } // pluginAttrs;

  meta = {
    description = "The Very Large Image Viewer";
    homepage = "https://github.com/delhoume/vliv";
    changelog = "https://github.com/delhoume/vliv/releases/v${finalAttrs.version}";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.phanirithvij ];
    mainProgram = "vliv.exe";
    # platforms = [ "x86_64-linux" ]; # TODO wineWow64Package.stableFull.meta.platforms (x64 linux and mac) ++ windows?
  };
})
