# https://github.com/NotAShelf/nvf/blob/main/configuration.nix
{ pkgs, ... }:
let
  nvf = builtins.getFlake "github:NotAShelf/nvf/92812036cce52687a9e089858d79f0e96c43c64c";
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
