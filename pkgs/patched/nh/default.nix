{ nh, nix-output-monitor, ... }:
nh.override {
  # this comes from flakePkgs, thus requiring custom override to nh
  # ideally we have nh as a flake input and override nix-output-monitor flake input via follows mechanism
  inherit nix-output-monitor;
}
