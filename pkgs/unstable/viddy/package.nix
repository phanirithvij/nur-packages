{
  fetchFromGitHub,
  viddy,
}:
viddy.overrideAttrs (
  finalAttrs: _: {
    version = "master";
    src = fetchFromGitHub {
      owner = "sachaos";
      repo = "viddy";
      rev = "refs/heads/${finalAttrs.version}";
      hash = "sha256-rwS7Cc8RQXGb3GsQRjwansyMQiIOeFPayJgw2J2gujY=";
    };
    cargoHash = "sha256-d/wmjvbTITpcGCrMVZrkUcCFPDdas2CDDPlIqoVBl9k=";
  }
)
