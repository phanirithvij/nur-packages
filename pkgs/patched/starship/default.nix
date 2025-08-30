{ starship, ... }:
starship.overrideAttrs {
  patches = [ ./username-no-ssh.patch ];
}
