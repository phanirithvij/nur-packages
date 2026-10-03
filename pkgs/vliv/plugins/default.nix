{
  lib,
  applyPatches,
  fetchFromGitHub,
  pkgsCross,

  vliv,
}:
let
  vlivSrc = vliv.src;
  version = "git";
  pluginsSrc = applyPatches {
    src = fetchFromGitHub {
      owner = "delhoume";
      repo = "vlivplugins";
      rev = "refs/heads/main";
      hash = "sha256-u/FUj0o8P8n2LugKS5ExKmO+cSzaOK1+5oq+fwqrPCU=";
    };
    # TODO modify all plugins makefiles
    patches = [ ./plugins-mingw-mods.patch ];
  };
  stdenv = pkgsCross.mingwW64.stdenv;
  mkVlivPlugin =
    {
      src,
      pname,
      version,
      external ? false,
    }:
    let
      name = if pname == "internal" then "vliv" else pname;
      makefile = if pname == "wic" then "wichandler.mak" else "${pname}.mak";
      myLibwebp = pkgsCross.mingwW64.libwebp.override {
        gifSupport = false;
        tiffSupport = false;
        pngSupport = false;
        jpegSupport = false;
      };
      myLibtiff = pkgsCross.mingwW64.libtiff.override { libwebp = myLibwebp; };
    in
    stdenv.mkDerivation (finalAttrs: {
      pname = "vliv-plugin-${name}";
      inherit src version;
      sourceRoot =
        if external then
          "${finalAttrs.src.name}/${pname}"
        else
          "${finalAttrs.src.name}/src/plugins/${pname}";

      inherit makefile;
      makeFlags = [
        # TODO each plugin in separate derivaiton and readDir
        # Allows plugins to be minimal and independent
        "CC=${stdenv.cc.targetPrefix}cc"
        "CXX=${stdenv.cc.targetPrefix}c++"
        "VLIVDIR=."
        "STBDIR=${pkgsCross.mingwW64.stb}/include/stb"
        "EXRDIR=${pkgsCross.mingwW64.tinyexr}"
        "EXTRA_CFLAGS=-I${myLibwebp}/include -I${myLibtiff.dev}/include -I${pkgsCross.mingwW64.libjpeg.dev}/include -I${pkgsCross.mingwW64.zlib.dev}/include -I${pkgsCross.mingwW64.libpng.dev}/include"
      ];

      preBuild = ''
        # Copy and patch vliv.h locally to avoid read-only store path issues
        cp ${vlivSrc}/src/vliv.h .
        chmod +w vliv.h
        sed -i 's/^HMODULE languageInst;/extern HMODULE languageInst;/' vliv.h 2>/dev/null || true
        sed -i 's/typedef BOOL (\*ACCEPTF)(const unsigned char\* buffer, unsigned int size);/struct Image;\ntypedef BOOL (*ACCEPTF)(const unsigned char* buffer, long unsigned int size);/' vliv.h 2>/dev/null || true
      '';

      postPatch = ''
        # Fix includes
        sed -i 's/<debug.h>/"debug.h"/' debug.c 2>/dev/null || true
        sed -i 's/<lyapunov.h>/"lyapunov.h"/' lyapunov.c 2>/dev/null || true
        sed -i 's/<newton.h>/"newton.h"/' newton.c 2>/dev/null || true

        # GCC 14 requires math.h for log, fabs, pow
        sed -i '1i #include <math.h>' lyapunov.c newton.c 2>/dev/null || true

        # Fix prototypes
        sed -i 's/buffer, unsigned int size/buffer, long unsigned int size/' debug.c lyapunov.c newton.c 2>/dev/null || true

        # Convert MSVC makefile syntax to MinGW syntax
        if [ -f "${makefile}" ]; then
          sed -i 's/CC  = cl/CC = ${stdenv.cc.targetPrefix}cc/' "${makefile}"
          sed -i 's/LD  = link//' "${makefile}"
          sed -i 's/\/Ox/-O2/g' "${makefile}"
          sed -i 's/\/nologo \/W3/-Wall/g' "${makefile}"
          sed -i 's/\/D/-D/g' "${makefile}"
          sed -i 's/\/I/-I/g' "${makefile}"
          sed -i 's/\/c/-c/g' "${makefile}"
          sed -i 's/\.obj/.o/g' "${makefile}"
          sed -i 's/$(LD) \/dll \/out:\(.*\.dll\) .*\.o/$(CC) -shared -o \1 *.o/g' "${makefile}"
          sed -i 's/del /rm -f /g' "${makefile}"

          # Fix lyapunov and newton syslibs
          sed -i 's/wininet\.lib/-lwininet/g' "${makefile}"
          sed -i 's/user32\.lib/-luser32/g' "${makefile}"
          sed -i 's/gdi32\.lib/-lgdi32/g' "${makefile}"
          sed -i 's/kernel32\.lib/-lkernel32/g' "${makefile}"
          sed -i 's/comctl32\.lib/-lcomctl32/g' "${makefile}"
          sed -i 's/comdlg32\.lib/-lcomdlg32/g' "${makefile}"
          sed -i 's/shlwapi\.lib/-lshlwapi/g' "${makefile}"
          sed -i 's/shell32\.lib/-lshell32/g' "${makefile}"
          sed -i 's/advapi32\.lib/-ladvapi32/g' "${makefile}"
          sed -i 's/version\.lib/-lversion/g' "${makefile}"
          sed -i 's/strsafe\.lib//g' "${makefile}"
        fi
      '';
      postBuild = ''
        mkdir -p $out/lib
        cp ${name}.dll $out/lib/
      '';

      buildInputs = with pkgsCross.mingwW64; [
        myLibtiff
        zlib
        libjpeg
        libpng
        myLibwebp
      ];

      dontInstall = true;
      dontStrip = true;

      meta = {
        description = "${name}.dll plugin for vliv";
        homepage =
          if external then
            "https://github.com/delhoume/vlivplugins"
          else
            "https://github.com/delhoume/vliv/tree/main/src/plugins";
        maintainers = [ lib.maintainers.phanirithvij ];
        license = lib.licenses.mit;
      };
    });

  # from vliv src TODO maybe builins.readDir ${src} like dprint-plugins
  sourcePlugins = [
    "debug"
    "lyapunov"
    "newton"
  ];
  externalPlugins = [
    "avi" # done
    # "deepzoom" # disabled due to upstream C syntax errors in dzhandler.c
    # "exr" # done (disabled due to missing exr_reader.hh in tinyexr)
    # "jpeg2000" # disabled due to missing jasper support for MinGW
    "qoi" # done
    "stb" # done
    # "wic" # disabled because it hardcodes a Windows C:\ path for the SDK

    # but lives in external repo
    "internal" # produces vliv.dll
  ];

  pluginNames = sourcePlugins ++ externalPlugins;

  plugins = builtins.listToAttrs (
    map (
      pname:
      lib.nameValuePair pname (mkVlivPlugin {
        inherit (vliv) version;
        inherit pname;
        src = vlivSrc;
      })
    ) sourcePlugins
    ++ map (
      pname:
      lib.nameValuePair pname (mkVlivPlugin {
        inherit pname version;
        src = pluginsSrc;
        external = true;
      })
    ) externalPlugins
  );
  # should be able to configure vlivplugins!
  #   so vliv.withPlugins ( pp: with pp; [ tiff ... ] )?
  #   plugins folder
  withPlugins =
    p:
    let
      selectedPlugins = p plugins;
    in
    stdenv.mkDerivation {
      inherit (vliv) pname version;
      propagatedBuildInputs = selectedPlugins;
      dontUnpack = true;
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/lib
        for i in ''${propagatedBuildInputs[@]}; do
          cp -r $i/lib/*.dll $out/lib/ 2>/dev/null || true
        done
      '';
    };
in
{
  inherit plugins withPlugins mkVlivPlugin;
}
