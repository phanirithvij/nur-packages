{
  lib,
  buildGoModule,
  buildNpmPackage,
  fetchFromGitHub,
  fetchurl,
  goagen_1,
}:

let
  markedJsUrl = "https://cdn.jsdelivr.net/npm/marked@3.0.8/marked.min.js";
  markedJsFile = "marked@3.0.8.min.js";
  markedJs = fetchurl {
    url = markedJsUrl;
    hash = "sha256-ErAhHgL0Tl+XBwYGuvyTC+VF7tLpojj+gdW+FRNk/5c=";
    name = "marked@3.0.8.min.js";
  };
in

buildGoModule rec {
  pname = "feedpushr";
  version = "3.4.1-unstable-2025-01-27";

  src = fetchFromGitHub {
    owner = "ncarlier";
    repo = "feedpushr";
    rev = "0898e122482275b0743fd8b370599550a728efd6";
    hash = "sha256-quiv1Ul06ZKbYl10z4rk64U8m5hl1544p7ccEgmqUNw=";
    fetchSubmodules = true;
  };

  vendorHash = "";
  proxyVendor = true;

  ldflags = [
    "-s"
    "-X github.com/ncarlier/feedpushr/v3/pkg/version.Version=v${version}"
    "-X github.com/ncarlier/feedpushr/v3/pkg/version.GitCommit=${src.rev}"
    "-X github.com/ncarlier/feedpushr/v3/pkg/version.Built=v${version}"
  ];

  frontend = buildNpmPackage {
    pname = "feedpushr-frontend";
    inherit version src;
    sourceRoot = "${src.name}/ui";
    npmBuildScript = "build";
    dontInstall = true;
    postBuild = ''
      cp ${markedJs} build/static/js
      substituteInPlace build/index.html \
        --replace-fail ${markedJsUrl} ./static/js/${markedJsFile}
      mv build $out
    '';
    npmFlags = [ "--legacy-peer-deps" ];
    NODE_OPTIONS = "--openssl-legacy-provider";
    npmDepsHash = "sha256-SWPCG8hNwLUkX47mrytjhwgQKwir+f0+uVb/LL48jM4=";
  };

  # Recreate generated code for reproducibility
  # goagen requires goa sourcetree to be present in GOPATH
  preBuild = ''
    make clean 
    mkdir -p $GOPATH/src/github.com/{goadesign/goa,ncarlier/feedpushr/v3}
    cp -rT ${goagen_1}/share/src $GOPATH/src/github.com/goadesign/goa
    ln -s $PWD/design $GOPATH/src/github.com/ncarlier/feedpushr/v3/design
    cp -r ${frontend} pkg/assets/content/ui
    make autogen
  '';

  nativeBuildInputs = [ goagen_1 ];

  subPackages = [ "." ];

  meta = {
    description = "A simple feed aggregator daemon with sugar on top";
    homepage = "https://github.com/ncarlier/feedpushr";
    license = lib.licenses.gpl3Only;
    mainProgram = "feedpushr";
  };
}
