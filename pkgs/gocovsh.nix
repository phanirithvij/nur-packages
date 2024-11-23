{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "gocovsh";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "orlangure";
    repo = "gocovsh";
    rev = "v${version}";
    hash = "sha256-VZNu1uecFVVDgF4xDLTgkCahUWbM+1XASV02PEUfmr0=";
  };

  vendorHash = "sha256-Fb7BIWojOSUIlBdjIt57CSvF1a+x33sB45Z0a86JMUg=";

  # check pdfcpu drv if really need these
  # or write an update script
  ldflags = [
    "-s"
    "-X main.version=${version}"
    "-X main.commit=v${version}"
    "-X main.date=19700101T000000Z"
  ];

  meta = {
    description = "Go Coverage in your terminal: a tool for exploring Go Coverage reports from the command line";
    homepage = "https://github.com/orlangure/gocovsh";
    changelog = "https://github.com/orlangure/gocovsh/releases";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "gocovsh";
  };
}
