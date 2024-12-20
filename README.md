# nur-packages

**My personal [NUR](https://github.com/nix-community/NUR) repository**

### packages

| package       | version                    | source                                     | reason                                                                                                           |
| ------------- | -------------------------- | ------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| feedpushr     | 3.4-unstable-2024-07-08    | https://github.com/ncarlier/feedpushr      | rss notify via scripts                                                                                           |
| goagen_1      | 1.4.3                      | https://github.com/goadesign/goa/tree/v1   | oudated goadesign command, for feedpushr, can be deprecated once https://github.com/ncarlier/feedpushr/issues/93 |
| jampack       | 0.30.0-unstable-2024-10-11 | https://github.com/divriots/jampack        | can be used from inside node but packaged just in case                                                           |
| qbittorrentui | 0.3.6                      | https://github.com/rmartin16/qbittorrentui | use it in servers, lightweight webui client                                                                      |
| rsshub        | 0-unstable-2024-11-18      | https://github.com/DIYgod/RSSHub           | (failed to source upstream pr-tracker custom route) (nixpkgs upstream nixos module)                              |

### in nixpkgs

| package | url                                          | nixpkgs pr (by anyone)                       |
| ------- | -------------------------------------------- | -------------------------------------------- |
| diffnav | https://github.com/dlvhdr/diffnav/releases   | https://github.com/nixos/nixpkgs/pull/345587 |
| gtrash  | https://github.com/umlx5h/gtrash/releases    | https://github.com/NixOS/nixpkgs/pull/281705 |
| pik     | https://github.com/jacek-kurlit/pik/releases | https://github.com/NixOS/nixpkgs/pull/350269 |
| ufetch  | https://gitlab.com/jschx/ufetch              | https://github.com/NixOS/nixpkgs/pull/266274 |

### I maintain

| package       | url                                                | nixpkgs location                                                                       | pr                                           |
| ------------- | -------------------------------------------------- | -------------------------------------------------------------------------------------- | -------------------------------------------- |
| distrobox-tui | https://github.com/phanirithvij/distrobox-tui/tags | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/di/distrobox-tui/package.nix | https://github.com/NixOS/nixpkgs/pull/332765 |
| gama-tui      | https://github.com/termkit/gama/releases           | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/ga/gama-tui/package.nix      | https://github.com/NixOS/nixpkgs/pull/358316 |
| gh-i          | https://github.com/gennaro-tedesco/gh-i/releases   | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/gh/gh-i/package.nix          | https://github.com/NixOS/nixpkgs/pull/332765 |
| gitcs         | https://github.com/knbr13/gitcs/releases           | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/gi/gitcs/package.nix         | https://github.com/NixOS/nixpkgs/pull/332765 |
| gocovsh       | https://github.com/orlangure/gocovsh/releases      | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/go/gocovsh/package.nix       | https://github.com/NixOS/nixpkgs/pull/358316 |
| gogup         | https://github.com/nao1215/gup/releases            | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/go/gogup/package.nix         | https://github.com/NixOS/nixpkgs/pull/332765 |
| golds         | https://github.com/go101/golds/tags                | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/go/golds/package.nix         | https://github.com/NixOS/nixpkgs/pull/358316 |
| gomtree       | https://github.com/vbatts/go-mtree/releases        | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/go/gomtree/package.nix       | https://github.com/NixOS/nixpkgs/pull/332765 |
| opengist      | https://github.com/thomiceli/opengist/releases     | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/op/opengist/package.nix      | https://github.com/NixOS/nixpkgs/pull/349718 |
| pkgsite       | https://github.com/golang/pkgsite                  | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/pk/pkgsite/package.nix       | https://github.com/NixOS/nixpkgs/pull/358316 |
| tcount        | https://github.com/rrethy/tcount/releases          | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/tc/tcount/package.nix        | https://github.com/NixOS/nixpkgs/pull/358316 |
| viddy         | https://github.com/sachaos/viddy/releases          | https://github.com/NixOS/nixpkgs/blob/master/pkgs/by-name/vi/viddy/package.nix         | https://github.com/NixOS/nixpkgs/pull/336100 |

### NOTES

- To use the above derivations in your setup, copy and adapt, please don't use my repo directly.
  - As I will remove them from here if they get be upstreamed to nixpkgs.
  - And for that reason I don't plan to submit my repo to nur-community.
- found something in the repo horrendous? (>.<)
  - send a message in github issues and help me learn nix (please?)
- I don't have access to a mac, and thus I don't care about mac builds unless the need arises. (eg. upstreaming something in nixpkgs)
