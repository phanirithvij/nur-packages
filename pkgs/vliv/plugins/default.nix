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
      hash = "sha256-GQnRI1xAgpCLTpjCk2S8aA9BxBw58nsl89pqBdSjdps=";
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
        "VLIVDIR=${vlivSrc}/src"
        "STBDIR=${pkgsCross.mingwW64.stb}/include/stb"
        "EXRDIR=${pkgsCross.mingwW64.tinyexr}"
      ];
      postBuild = "cp ${name}.dll $out";

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
    "deepzoom"
    "exr" # done
    "jpeg2000"
    "qoi" # done
    "stb" # done
    "wic"

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
        for i in ''${propagatedBuildInputs[@]}; do
          echo $i
        done
        touch $out
      '';
    };
in
{
  inherit plugins withPlugins mkVlivPlugin;
}
