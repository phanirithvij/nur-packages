{
  lib,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  bpf-linker,
  pkg-config,
  zstd,
  buildPackages,
  symlinkJoin,
}:
let
  # https://github.com/NixOS/nixpkgs/issues/393680
  # 'RUST_SRC_PATH' is usually used when needing rust-src
  # but we have to have it in-tree here
  # from fluffychat/vodozemac-wasm.nix nixpkgs
  rustcWithLibSrc = buildPackages.rustc.override {
    sysroot = symlinkJoin {
      name = "rustc_unwrapped_with_libsrc";
      paths = [
        buildPackages.rustc.unwrapped
      ];
      postBuild = ''
        mkdir -p $out/lib/rustlib/src/rust
        ln -s ${rustPlatform.rustLibSrc} $out/lib/rustlib/src/rust/library
      '';
    };
  };
in
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "ttyrecall";
  #version = "0.0.1-unstable-2025-04-08"; # main
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "kxxt";
    repo = "ttyrecall";
    #rev = "3dce604721f56d2b870ee5a64dd5f725af71e560"; # main
    #hash = "sha256-paBmi3Od4iXVRT/gE//NfuCXiE2iCYvwj11lXrQIbec="; # main
    tag = "v${finalAttrs.version}";
    hash = "sha256-ZFOQuyJJf8HYNvTzXT4YuL2fF6Xk/L6VmPMUIurMRw4="; # 0.0.1
  };

  # from fluffychat/vodozemac-wasm.nix nixpkgs
  cargoDeps = symlinkJoin {
    name = "ttyrecall-cargodeps";
    paths = [
      (rustPlatform.fetchCargoVendor {
        inherit (finalAttrs) pname version src;
        #hash = "sha256-JXeQSJumOyyqEY0c7ulWVIbiugDtKp8s7mqc5XuQaSg="; # main
        hash = "sha256-KhqXB2gSa322YdMgWaITj0ynyrNdhZAH6r1H8h+irqA="; # 0.0.1
      })
      (rustPlatform.fetchCargoVendor {
        inherit (finalAttrs) version src;
        pname = "ttyrecall-ebpf-cargodeps";
        sourceRoot = "${finalAttrs.src.name}/ttyrecall-ebpf";
        hash = "sha256-dRdHcgzZaQL+L439x1+Uucyr5mG7ioODLWLZtw5VQHg=";
      })
      # Pull in rust vendor so we don't have to vendor rustLibSrc again
      # This is required because `-Z build-std=core`
      rustPlatform.rustVendorSrc
    ];
  };

  nativeBuildInputs = [
    rustcWithLibSrc
    pkg-config
    bpf-linker
    rustPlatform.bindgenHook
    installShellFiles
  ];

  buildInputs = [ zstd ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
    RUSTC_BOOTSTRAP = true; # needed for eBPF build-std=core
    CARGO_TARGET_BPF_LINKER = "${bpf-linker}/bin/bpf-linker";
  };

  buildPhase = ''
    runHook preBuild
    cargo xtask build --release
    runHook postBuild
  '';

  buildAndTestSubdir = "."; # TODO check if required

  postBuild = ''
    # Generate shell completions
    local compgen="target/release/ttyrecall generate-completion"
    mkdir -p completions
    $compgen bash > completions/ttyrecall
    $compgen elvish > completions/ttyrecall.elv
    $compgen fish > completions/ttyrecall.fish
    $compgen zsh > completions/_ttyrecall
  '';

  installPhase = ''
    runHook preInstall

    install -Dm755 target/release/ttyrecall $out/bin/ttyrecall

    # Install shell completions
    installShellCompletion --cmd ttyrecall \
      --bash completions/ttyrecall \
      --fish completions/ttyrecall.fish \
      --zsh completions/_ttyrecall
    install -Dm644 completions/ttyrecall.elv $out/share/elvish/lib/ttyrecall.elv

    # Install config example
    install -Dm644 etc/daemon.toml $out/share/doc/ttyrecall/daemon.toml.example

    runHook postInstall
  '';

  checkType = "release";
  cargoCheckFlags = [
    "--package=ttyrecall"
    "--package=ttyrecall-common"
    #"--package=ttyrecall-ebpf" # can't because no_std https://users.rust-lang.org/t/cargo-test-not-working-on-no-std/92902
  ];

  meta = {
    description = "Recall, but for terminal - continuously record your terminal sessions";
    longDescription = ''
      ttyrecall is a terminal session recorder that runs continuously in the background,
      capturing all terminal output in asciicast-v2 format with zstd compression.
      Similar to asciinema, but always on. Inspired by Microsoft's Recall feature.
    '';
    homepage = "https://github.com/kxxt/ttyrecall";
    license = with lib.licenses; [
      agpl3Plus # Main binary
      gpl2Plus # eBPF module
      mit0 # Common library
    ];
    maintainers = with lib.maintainers; [ phanirithvij ];
    platforms = lib.platforms.linux;
    mainProgram = "ttyrecall";
  };
})
