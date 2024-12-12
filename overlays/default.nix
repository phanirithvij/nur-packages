{
  navi-overlay = import ./navi-master.nix;
  pr-tracker-overlay = import ./pr-tracker-overlay.nix;
  git-bug-overlay = import ./git-bug-master.nix;

  # TODO remove later once I get sync working?
  # minimal client build, no server
  atuin-overlay = _: p: {
    atuin = p.atuin.overrideAttrs (_: {
      buildFeatures = [ "client" ];
    });
  };

  nix-schema-overlay = _: _: {
    nix-schema = import ../pkgs/nix-schema.nix;
  };
}
