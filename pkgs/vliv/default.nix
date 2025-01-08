{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "vliv";
  version = "2.6.0"; # TODO v2.7.0

  # TODO fetcurl github release 64bit (That should be in vliv-bin)
  # TODO upstream gha release script for both 32 and 64 bins?
  #    repo has a makefile, should be easy enough with cl.exe stuff
  # TODO 32bit and 64bit bins in $out, with override args, only 64 enabled by default
  # or in all-packages provide vliv32 and vliv
  src = fetchFromGitHub {
    owner = "delhoume";
    repo = "vliv";
    tag = "v${finalAttrs.version}";
    hash = "sha256-V9Gac8MZhlt/rx6fJwqA/D5mB6bdPJ3rEnY2kPe1990=";
  };
  sourceRoot = "${finalAttrs.src.name}/src";

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
  # headers folder, so it should be used as a library
  #   dev output? not likely just $out/devel?
  # should run on windows (cross compiled .exe via nix)
  # should run on macos wine (does normally according to author)
  #   on macos it seems wineWowPackages.stableFull.meta.platforms doesn't work
  #   maybe it works with wineWow64Packages.stableFull
  #   maybe if I get 32bit latest ver it can work with macos old 32bit 13.0 macos with wine32
  # nixostest for linux 32bit, 64bit binaries
  #   drag drop test file in gui (possible?)
  #   headers test by writing a simple hello world thing using vliv source code

  meta = {
    description = "The Very Large Image Viewer";
    license = lib.licenses.mit;
    changelog = "https://github.com/delhoume/vliv/releases/v${finalAttrs.version}";
    homepage = "https://github.com/delhoume/vliv";
    platforms = [ "x86_64-linux" ]; # TODO wineWow64Package.stableFull.meta.platforms (x64 linux and mac) ++ windows?
    maintainers = [ lib.maintainers.phanirithvij ];
  };
})
