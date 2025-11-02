## what

Flakes are cool except they are not.

They provide upstream intended dependencies, and *2nix solutions can be
leveraged, proper dependency management unlike something else (python packages
in nixpkgs). So are ideally guarenteed to work if kept up-to-date by upstream.

But they come with severe downsides. which I need to link here, TBA.

One major one being 10000 nixpkgs. Other being taking around infinite time to
eval and constantly getting copied to nix store. I swear to god if I ever see
copying /nix/store/...-something to nix store again I will crash out.

Considering all of this, builtins.getFlake is an escape hatch. Even it has a
ADDITIONAL severe limitation which disallows overriding nixpkgs (flake inputs in
general) along with all of flakes's issues listed above.

flakes pollute my system flake with hundreds of programs, making nix flake
metadata look ungodly.

In this rock and a hard place scenario let 10000s of nixpkgs rain on me and I
thus welcome builtins.getFlake.

![knife storm adventure time](https://web.archive.org/web/20251102070232if_/https://overlydevotedarchivist.net/wp-content/uploads/2020/04/adt4.gif?w=435)

I can't override nixpkgs but can override individual derivations.

for e.g.

```nix
# nh comes from nixpkgs unstable (can be from builtins.getFlake if it stops working with flake nom)
nh.override {
    inherit nix-output-monitor; # comes from builtins.getFlake
}
```
