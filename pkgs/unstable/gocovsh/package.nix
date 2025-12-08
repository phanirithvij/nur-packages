{
  fetchFromGitHub,
  gocovsh,
}:
gocovsh.overrideAttrs (
  finalAttrs: _: {
    version = "0.6.1-unstable-2025-12-05";
    src = fetchFromGitHub {
      owner = "orlangure";
      repo = "gocovsh";
      rev = "c984bf867e1b67160321d221dceebc45003f5105";
      hash = "sha256-cFDPnV6ALkw8LsoQfP6q4tLkT3kmb+1a0uidrvVXQfM=";
    };
    vendorHash = "sha256-Fb7BIWojOSUIlBdjIt57CSvF1a+x33sB45Z0a86JMUg=";
    ldflags = [
      "-s"
      "-X main.version=${finalAttrs.version}"
      "-X main.commit=v${finalAttrs.version}"
      "-X main.date=19700101T000000Z"
    ];
  }
)
