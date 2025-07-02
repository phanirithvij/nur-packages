{
  fetchFromGitHub,
  gocovsh,
}:
gocovsh.overrideAttrs (
  finalAttrs: _: {
    version = "0.6.1-unstable-2024-01-17";
    src = fetchFromGitHub {
      owner = "orlangure";
      repo = "gocovsh";
      rev = "8880bc63283c13a1d630ce3817c7165a6c210d46";
      hash = "sha256-0BiJaIpjMe+Jpb+HDC6/axi0LMcBCcpLxbtiWQlxkYY=";
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
