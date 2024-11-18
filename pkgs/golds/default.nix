{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "golds";
  version = "0.7.1";

  src = fetchFromGitHub {
    owner = "go101";
    repo = "golds";
    rev = "v${version}";
    hash = "sha256-6YkyKJtSAFFYidMlZXSjNpjyIIaTlibg/QMMin/NbU0=";
  };

  patches = [ ./info_module-gover.patch ];

  vendorHash = "sha256-omjHRZB/4VzPhc6RrFY11s6BRD69+Y4RRZ2XdeKbZf0=";

  ldflags = [ "-s" ];

  meta = {
    description = "An experimental Go local docs server/generator and code reader implemented with some fresh ideas";
    homepage = "https://github.com/go101/golds";
    license = lib.licenses.mit;
    mainProgram = "golds";
  };
}
