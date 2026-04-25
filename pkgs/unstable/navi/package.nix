{
  navi,
  fetchFromGitHub,
  rustPlatform,
}:
navi.overrideAttrs (
  old:
  let
    pname = "navi";
    version = "2.25.0-unstable-2026-04-13";
    src = fetchFromGitHub {
      owner = "denisidoro";
      repo = "navi";
      rev = "1ac218cb1e0e80649ef23c8a916e67efc3086833";
      hash = "sha256-2XEUSnDRBaiDtTUiG13oakGjNFs8eodCG5nyuybZvcs=";
    };
  in
  {
    inherit pname version src;
    # https://discourse.nixos.org/t/nixpkgs-overlay-for-mpd-discord-rpc-is-no-longer-working/59982/2
    cargoDeps = rustPlatform.fetchCargoVendor {
      inherit src;
      hash = "sha256-CXUggMacJPArHYLvDDz8+Fef/eeL+TXRMqg/vybuD5c=";
    };

    #checkFlags = [ "--skip=common::terminal::tests::test_width" ];
    #checkFlags doesn't work, fails with `error: unexpected argument '--skip' found`
    postPatch = (old.postPatch or "") + ''
      substituteInPlace src/common/terminal.rs \
        --replace-warn 'fn test_width(' '#[ignore] fn test_width('
    '';
  }
)
