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
  version = "2.7.1";

  # TODO 32bit and 64bit bins in $out, with override args, only 64 enabled by default
  # or in all-packages provide vliv32 and vliv
  src = applyPatches {
    src = fetchFromGitHub {
      owner = "delhoume";
      repo = "vliv";
      tag = "v${finalAttrs.version}";
      hash = "sha256-wmhOhs4Z7L85l3L3xZI5fHXSvMwFOLM+U0xn1RB9esI=";
    };
  };
  sourceRoot = "${finalAttrs.src.name}/src";

  postPatch = ''
        # Replace MSVC makefile with MinGW one
        cat > makefile <<'EOF'
    DEBUG = -O2
    VERSION = 2.7
    VERSIONSHORT = 270

    CFLAGS = -Wall $(DEBUG) -D_CRT_SECURE_NO_DEPRECATE -DWIN32 -DWINDOWS -I.
    LDFLAGS = $(LDDEBUG) -mwindows -Wl,--major-image-version,2 -Wl,--minor-image-version,7

    SYSLIBS = -lwininet -luser32 -lgdi32 -lkernel32 -lcomctl32 -lcomdlg32 -lshlwapi \
              -lshell32 -ladvapi32 -lversion -lmsimg32 -lwinmm

    OBJECTS = vliv.o urlctrl.o dialogs.o handlers.o bitmap.o recent.o window.o tilemgr.o rawinput.o

    all: vliv.exe

    %.o: %.c
    	$(CC) $(CFLAGS) -c $< -o $@

    vliv-res.o: resources/vliv.rc
    	$(RC) -i $< -o $@

    vliv.exe: $(OBJECTS) vliv-res.o
    	$(CC) -o $@ $(OBJECTS) vliv-res.o $(LDFLAGS) $(SYSLIBS)

    languages: fra.dll

    fra.dll: resources/fra.rc
    	$(RC) -i $< -o fra.o
    	$(CC) -shared -o $@ fra.o -Wl,--subsystem,windows

    clean:
    	rm -f *.o *.exe *.dll *.res *~
    EOF

        # Force hard tabs for makefile rules just in case
        sed -i 's/^  *$(CC)/\t$(CC)/' makefile
        sed -i 's/^  *$(RC)/\t$(RC)/' makefile
        sed -i 's/^  *rm /\trm /' makefile

        # Fix multiple definition of languageInst for GCC >= 10
        sed -i 's/^HMODULE languageInst;/extern HMODULE languageInst;/' vliv.h
        sed -i '/static TCHAR \*SubFileTypeNames\[4\];/a HMODULE languageInst;' vliv.c

        # Fix multiple definition of bPrint and abortDialog
        sed -i 's/^HWND abortDialog;/extern HWND abortDialog;/' dialogs.h
        sed -i 's/^BOOL bPrint;/extern BOOL bPrint;/' dialogs.h
        sed -i '/#include <dialogs.h>/a HWND abortDialog;\nBOOL bPrint;' dialogs.c

        # Fix prototype in vliv.h for 64-bit size
        sed -i 's/typedef BOOL (\*ACCEPTF)(const unsigned char\* buffer, unsigned int size);/struct Image;\ntypedef BOOL (*ACCEPTF)(const unsigned char* buffer, long unsigned int size);/' vliv.h

        # Fix case-sensitive DLL loading
        sed -i 's/"ownd.dll"/"Ownd.dll"/' vliv.c

        # Fix MinGW missing strcat_s
        sed -i 's/strcat_s(szValue, sizeof(szValue), "o");/strcat(szValue, "o");/' dialogs.c

        # Fix static declaration errors for GCC 14
        sed -i 's/static void ScrollWithOffset/void ScrollWithOffset/' vliv.c
        sed -i 's/static void LoadTile/void LoadTile/' vliv.c

        # Fix prototype in handlers.c for 64-bit size
        sed -i 's/unsigned int size/long unsigned int size/g' handlers.c

        # Fix windres comma requirements in vliv.rc
        sed -i 's/MENUITEM "Clear Recent File List"       ID_TOOLS_CLEAR/MENUITEM "Clear Recent File List",      ID_TOOLS_CLEAR/' resources/vliv.rc
        sed -i 's/MENUITEM "Fullscreen\\tEnter"            ID_TOOLS_FULLSCREEN/MENUITEM "Fullscreen\\tEnter",           ID_TOOLS_FULLSCREEN/' resources/vliv.rc
        sed -i 's/MENUITEM "Register..."                  ID_TOOLS_REGISTER/MENUITEM "Register...",                 ID_TOOLS_REGISTER/' resources/vliv.rc
        sed -i 's/MENUITEM "Export Current View as BMP..." ID_TOOLS_EXPORTBMP/MENUITEM "Export Current View as BMP...", ID_TOOLS_EXPORTBMP/' resources/vliv.rc
        sed -i 's/MENUITEM "Copy Current View to Clipboard\\tCtrl+C" ID_TOOLS_CLIPBOARD/MENUITEM "Copy Current View to Clipboard\\tCtrl+C", ID_TOOLS_CLIPBOARD/' resources/vliv.rc

        # Fix case-sensitive resource paths
        sed -i 's/"myinfo2.ico"/"MyInfo2.ico"/' resources/vliv.rc
  '';

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
  }
  // pluginAttrs;

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
