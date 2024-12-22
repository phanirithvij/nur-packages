{
  fetchFromGitHub,
  gocovsh,
}:
gocovsh.overrideAttrs (
  finalAttrs: _: {
    version = "master";
    src = fetchFromGitHub {
      owner = "orlangure";
      repo = "gocovsh";
      rev = "refs/heads/${finalAttrs.version}";
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
