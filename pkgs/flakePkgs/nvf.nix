# https://github.com/NotAShelf/nvf/blob/main/configuration.nix
{ pkgs, ... }:
let
  nvf = builtins.getFlake "github:NotAShelf/nvf/21849b62be17c6657accbf4e0c9e1afe57e27ea3";
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
          typescript.enable = true;
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
        minimap = {
          # https://github.com/NotAShelf/nvf/issues/1312#issuecomment-3719470693
          codewindow.enable = false;
        };
        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };
        comments = {
          comment-nvim.enable = true;
        };
        binds = {
          whichKey.enable = true;
        };
        maps.normal."<leader>bf" = {
          action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
          desc = "Fuzzy find in current buffer";
        };
      };
    })
  ];
}).neovim.overrideAttrs
  (o: {
    meta = o.meta // pkgs.neovim-unwrapped.meta;
  })
