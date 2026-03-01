# https://github.com/NotAShelf/nvf/blob/main/configuration.nix
{ pkgs, ... }:
let
  nvf = builtins.getFlake "github:phanirithvij/nvf/0e47bce8e9a628f2a949a00118cd1315a8bfa3a8";
in
(nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [
    (_: {
      config.vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          trouble.enable = true;
        };
        languages = {
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true;
          nix.format.type = [ "nixfmt" ];
          markdown.enable = true;
          markdown.extensions.render-markdown-nvim.enable = true;
          bash.enable = true;
          css.enable = true;
          elm.enable = true;
          html.enable = true;
          ts.enable = true;
          go.enable = true;
          lua.enable = true;
          zig.enable = true;
          python.enable = true;
        };
        autopairs.nvim-autopairs.enable = true;
        autocomplete.nvim-cmp.enable = true;
        snippets.luasnip.enable = true;
        filetree = {
          neo-tree = {
            enable = true;
          };
        };
        treesitter.context.enable = true;
        telescope.enable = true;
        git.enable = true;
        minimap.codewindow.enable = false; # https://github.com/NotAShelf/nvf/issues/1312#issuecomment-3719470693
        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };
        comments = {
          comment-nvim.enable = true;
        };
      };
    })
  ];
}).neovim.overrideAttrs
  (o: {
    meta = o.meta // pkgs.neovim-unwrapped.meta;
  })
