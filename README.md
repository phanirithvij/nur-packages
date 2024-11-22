# nur-packages

**My personal [NUR](https://github.com/nix-community/NUR) repository**

| package       | version                    | source                                        | reason                                                                                                           |
| ------------- | -------------------------- | --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| feedpushr     | 3.4-unstable-2024-07-08    | https://github.com/ncarlier/feedpushr         | rss notify via scripts                                                                                           |
| gama          | 1.1.4-unstable-2024-09-05  | https://github.com/termkit/gama               | might upstream                                                                                                   |
| goagen_1      | 1.4.3                      | https://github.com/goadesign/goa/tree/v1      | oudated goadesign command, for feedpushr, can be deprecated once https://github.com/ncarlier/feedpushr/issues/93 |
| gocovsh       | 0.6.1                      | https://github.com/orlangure/gocovsh/releases | contrib once                                                                                                     |
| golds         | 0.6.9                      | https://github.com/go101/golds                | godoc alternative                                                                                                |
| gtrash        | 0.0.6                      | https://github.com/umlx5h/gtrash              | trash cli in go                                                                                                  |
| jampack       | 0.30.0-unstable-2024-10-11 | https://github.com/divriots/jampack           | can be used from inside node but packaged just in case                                                           |
| pik           | 0.9.0                      | https://github.com/jacek-kurlit/pik           | ps fzf                                                                                                           |
| qbittorrentui | 0.3.6                      | https://github.com/rmartin16/qbittorrentui    | use it in servers, lightweight webui client                                                                      |
| rsshub        | 0-unstable-2024-11-18      | https://github.com/DIYgod/RSSHub              | pr-tracker custom route (failed to upstream custom route) (nixpkgs upstream nixos module)                        |
| tcount        | 0-unstable-2023-04-20      | https://github.com/rrethy/tcount              | (upstreamable)                                                                                                   |
| ufetch        | 0.3                        | https://gitlab.com/jschx/ufetch               | minimal bash fetch + custom patch see https://github.com/mrtnvgr/nixpkgs/pull/1/files                            |

| package | url                                        | nixpkgs pr (by anyone)                       |
| ------- | ------------------------------------------ | -------------------------------------------- |
| diffnav | https://github.com/dlvhdr/diffnav/releases | https://github.com/nixos/nixpkgs/pull/345587 |

### NOTES

- To use the above derivations in your setup, copy and adapt, please don't use my repo directly.
  - As I will remove them from here if they get be upstreamed to nixpkgs.
  - And for that reason I don't plan to submit my repo to nur-community.
- found something in the repo horrendous? (>.<)
  - send a message in github issues and help me learn nix (please?)
- I don't have access to a mac, and thus I don't care about mac builds unless the need arises. (eg. upstreaming something in nixpkgs)

### TODO

- [ ] overlays
  - navi-master (needed it once, not anymore)
  - git-bug-master (one day github -> git-bug local first)
  - pr-tracker-patched (follow pr-tracker init pr nixpkgs)
- [ ] nixos modules
  - teldrive (immich is a good one for inspiration)
  - cloudflared ??
  - opengist
  - snips.sh
- [ ] hm modules
  - espanso wayland+x11 overlay?
- [ ] lib
  - funcs that might be useful
  - as of now use it as a bookmark/snippet/learnings wiki for useful nixpkgs funcs
    - patchShebangs w/ chmod +x
    - substituteInplace --replace-{fail,...}
    - override
    - overrideAttrs
    - overrideModAttrs (find a discourse thread for this as an example)
    - packageOverrides ??
    - extensible (packagesWith)
  - create a real wiki article and remove here?
    - under nixpkgs contrib > good to know (tent.)
