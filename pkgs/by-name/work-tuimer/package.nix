{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "work-tuimer";
  version = "0.2.0";

  src = fetchFromGitHub {
    owner = "Kamyil";
    repo = "work-tuimer";
    tag = "v${finalAttrs.version}";
    hash = "sha256-zj+B1LCyeoHnAsH+W77lq5BYWql6SBTsvCbd/uPsO/c=";
  };

  cargoHash = "sha256-9glLCDMc1wcD1NsBrd+ZG1zwXy7f8870zAlUAYbTNZM=";

  meta = {
    changelog = "https://github.com/Kamyil/work-tuimer/releases/tag/${finalAttrs.src.tag}";
    description = "Keyboard-driven TUI for time-tracking";
    homepage = "https://github.com/Kamyil/work-tuimer";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ phanirithvij ];
    mainProgram = "work-tuimer";
  };
})
