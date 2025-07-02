{
  fetchFromGitHub,
  gh-i,
}:
gh-i.overrideAttrs (
  finalAttrs: _: {
    version = "0.0.10-unstable-2024-11-25";
    src = fetchFromGitHub {
      owner = "gennaro-tedesco";
      repo = "gh-i";
      rev = "917dfceebaac5b24bb39049707fd77d0b1e3bccb";
      hash = "sha256-iIs6LcW8b1BqG1h87FnJQjdllbfY5GhEZcmIQ60hqAg=";
    };
    vendorHash = "sha256-eqSAwHFrvBxLl5zcZyp3+1wTf7+JmpogFBDuVgzNm+w=";
  }
)
