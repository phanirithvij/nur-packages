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
        # "EXRDIR=${pkgsCross.mingwW64.tinyexr}"
        "EXTRA_CFLAGS=-I${myLibwebp}/include -I${myLibtiff.dev}/include -I${pkgsCross.mingwW64.libjpeg.dev}/include -I${pkgsCross.mingwW64.zlib.dev}/include -I${pkgsCross.mingwW64.libpng.dev}/include"
      ];

      preBuild = ''
        # Copy vliv.h locally (already patched via applyPatches)
        cp ${vlivSrc}/src/vliv.h .
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
