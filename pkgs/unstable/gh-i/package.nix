{
  fetchFromGitHub,
  gh-i,
}:
gh-i.overrideAttrs (
  finalAttrs: _: {
    version = "master";
    src = fetchFromGitHub {
      owner = "gennaro-tedesco";
      repo = "gh-i";
      rev = "refs/heads/${finalAttrs.version}";
      hash = "sha256-iIs6LcW8b1BqG1h87FnJQjdllbfY5GhEZcmIQ60hqAg=";
    };
    vendorHash = "sha256-eqSAwHFrvBxLl5zcZyp3+1wTf7+JmpogFBDuVgzNm+w=";
  }
)
