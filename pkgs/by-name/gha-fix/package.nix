{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule (finalAttrs: {
  pname = "gha-fix";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "Finatext";
    repo = "gha-fix";
    tag = "v${finalAttrs.version}";
    hash = "sha256-k/up/9rQ2tKGNY03WNAXqJFgLbZMeSeuThT7exfh4D4=";
  };

  vendorHash = "sha256-CJUTODFiSO1k26ZcCJVQXQvoXzb34eLoAa6FzXxAo/o=";

  ldflags = [ "-s" ];

  meta = {
    description = "Automates security and maintenance fixes in GitHub Actions workflows";
    homepage = "https://github.com/Finatext/gha-fix";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "gha-fix";
  };
})
