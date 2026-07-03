## Minimal firmware per host/hardware

> [!IMPORTANT]
> Requires a nix substituter configured with write access to push the built
> minimal firmware derivation to it.
>
> Without a nix substituter it still pulls the full ~900MB linux-firmware
> package to build this smaller derivation. So not that useful.

This enables all firmware, if you have it somewhere, comment it.

```nix
# imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
```

Turn this off by hunting for `hardware.enableRedistributableFirmware`. eg. using
`facter` enables it. If it is `true` it will pull more firmware, if you feel
they are required for your host, still disable it and manually add them below,
like I do for `wireless-regdb`.

```console
$ nixos-option -F . hardware.enableRedistributableFirmware
```

Default value of `config.enableRedistributableFirmware` is `enableAllFirmware`
which is false by default.

Main option to find out what firmware files are required for a specific
hardware. Enable this, switch and reboot.

```nix
# https://serverfault.com/questions/1026598/know-which-firmware-my-linux-kernel-has-loaded-since-booting
# https://github.com/search?q=language%3ANix+dyndbg+AND+drivers%2Fbase%2Ffirmware_loader%2Fmain.c&type=code
# https://github.com/NixOS/nixpkgs/issues/148197#issuecomment-1121407764
#   https://github.com/samueldr/nixpkgs/commit/cbf7aa4ca386a7a0165aa0531772523760402861
boot.kernelParams = [ ''dyndbg="file drivers/base/firmware_loader/main.c +fmp"'' ];
```

Once rebooted run:

```bash
$ sudo dmesg | rg 'Loading firmware.*(/nix/store/[a-z0-9]{32}-[^[:space:]]+)' -o -r '$1' | xargs -d'\n' -I{} realpath {}
/nix/store/[...]-wireless-regdb-2025.02.20-zstd/lib/firmware/regulatory.db.zst
/nix/store/[...]-wireless-regdb-2025.02.20-zstd/lib/firmware/regulatory.db.p7s.zst
/nix/store/[...]-linux-firmware-20250627-zstd/lib/firmware/iwlwifi-7265D-29.ucode.zst
/nix/store/[...]-linux-firmware-20250627-zstd/lib/firmware/i915/kbl_dmc_ver1_04.bin.zst
$ sudo dmesg | rg 'firmware .* failed with error'
bluetooth hci0: Direct firmware load for intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq failed with error -2
bluetooth hci0: Direct firmware load for intel/ibt-hw-37.8.bseq failed with error -2
```

Finally configure it like so.

```nix
  # hardware.firmwareCompression is zstd by default (it is auto, but for new kernels it is zstd)
  hardware.firmwareCompression = "none"; # disable because I do it myself, it isn't idempotent
  # enabled in nixos/modules/services/networking/networkmanager.nix
  hardware.wirelessRegulatoryDatabase = lib.mkForce false; # I add the compressed version myself

  hardware.firmware = with pkgs; [
    (compressFirmwareZstd wireless-regdb)
    pkgs.nurPkgs.linux-firmware-iron-zstd # custom filtered firmware files
    # (compressFirmwareZstd linux-firmware) # original nixpkgs equivalent
  ];
```

Don't forget to update this, microcode updates are very important. (`intel` or
`amd`)

```nix
# hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
```

### TODO

- [ ] You can split up linux-firmware pacakge into million little pieces like
      alpine or a few pieces like arch. This allows installer scan step.
- [ ] nixos-generate-config installer scan step can scan for loaded firmware
      files and detect required set of firmware packages.
- [ ] No substituter means still works but not that useful in terms of closure
      size during download. a nix store gc will free up space so not completely
      useless.
- [ ] blog article?
- [ ] helper `mkMinimalFirmware` function in nixpkgs?
