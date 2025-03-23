# https://github.com/NotAShelf/nvf/blob/main/configuration.nix
{ pkgs, ... }:
let
  nvf = builtins.getFlake "github:NotAShelf/nvf/14fb42562e346e689d002c505fbc06b8a0d40b21";
in
(nvf.lib.neovimConfiguration {
  inherit pkgs;
  modules = [
    (_: {
      config.vim = {
        viAlias = true;
        vimAlias = true;
        lsp = {
          formatOnSave = true;
          lightbulb.enable = true;
          trouble.enable = true;
        };
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;

          nix.enable = true;
          nix.format.type = "nixfmt";
          markdown.enable = true;
          bash.enable = true;
          css.enable = true;
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
        minimap.codewindow.enable = true;
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
}).neovim
