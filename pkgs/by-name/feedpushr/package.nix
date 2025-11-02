{
  lib,
  buildGoModule,
  buildNpmPackage,
  fetchFromGitHub,
  fetchurl,
  goagen_1,
}:

buildGoModule (finalAttrs: {
  pname = "feedpushr";
  version = "3.4.1-unstable-2025-05-02";

  src = fetchFromGitHub {
    owner = "ncarlier";
    repo = "feedpushr";
    rev = "639fdb39f3b1ee1be240491152441e0fe837e5af";
    hash = "sha256-L5T7W+ogHY6PNILONqOWDWWNeDejtDBt7owHDEhs8pE=";
    fetchSubmodules = true;
  };

  vendorHash = "sha256-P3fc2uDyX1kqwgJbEVkusRyUg5bFdgIS/yoCCRMh5oM=";
  proxyVendor = true;

  ldflags = [
    "-s"
    "-X github.com/ncarlier/feedpushr/v3/pkg/version.Version=v${finalAttrs.version}"
    "-X github.com/ncarlier/feedpushr/v3/pkg/version.GitCommit=${finalAttrs.src.rev}"
    "-X github.com/ncarlier/feedpushr/v3/pkg/version.Built=v${finalAttrs.version}"
  ];

  markedJs = fetchurl {
    name = "marked@3.0.8.min.js";
    url = "https://cdn.jsdelivr.net/npm/marked@3.0.8/marked.min.js";
    hash = "sha256-ErAhHgL0Tl+XBwYGuvyTC+VF7tLpojj+gdW+FRNk/5c=";
  };

  frontend = buildNpmPackage {
    pname = "feedpushr-frontend";
    inherit (finalAttrs) version src;
    sourceRoot = "${finalAttrs.src.name}/ui";
    npmBuildScript = "build";
    dontInstall = true;
    postBuild = ''
      cp ${finalAttrs.markedJs} build/static/js
      substituteInPlace build/index.html --replace-fail \
        ${finalAttrs.markedJs.url} ./static/js/${finalAttrs.markedJs.name}
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
    cp -r ${finalAttrs.frontend} pkg/assets/content/ui
    #export GO111MODULE=off
    #cd $GOPATH/src
    #go get github.com/dimfeld/httppath
    #go get github.com/gofrs/uuid
    #go get github.com/manveru/faker
    #go get github.com/zach-klippenstein/goregen
    #go get golang.org/x/tools/go/ast/astutil
    goagen bootstrap -o autogen -d github.com/ncarlier/feedpushr/v3/design

    #go get github.com/goadesign/goa/goagen/codegen@v1.4.3
    make autogen
  '';

  nativeBuildInputs = [ goagen_1 ];

  subPackages = [ "." ];

  meta = {
    description = "A simple feed aggregator daemon with sugar on top";
    homepage = "https://github.com/ncarlier/feedpushr";
    license = lib.licenses.gpl3Only;
    mainProgram = "feedpushr";
    broken = true;
  };
})
