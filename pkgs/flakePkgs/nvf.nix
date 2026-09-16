# https://github.com/NotAShelf/nvf/blob/main/configuration.nix
{ pkgs, ... }:
let
  nvf = builtins.getFlake "github:NotAShelf/nvf/5e4f212f8720c17fdd06f5c57591f251aff67453";
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
          rust.enable = true;
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
        keymaps = [
          {
            key = "<leader>bf";
            mode = "n";
            silent = true;
            action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
            desc = "Fuzzy find in current buffer";
          }
        ];
      };
    })
  ];
}).neovim.overrideAttrs
  (o: {
    meta = o.meta // pkgs.neovim-unwrapped.meta;
  })
