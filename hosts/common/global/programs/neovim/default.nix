# template copied from https://github.com/LazyVim/LazyVim/discussions/1972
{
  config,
  lib,
  pkgs,
  ...
}:
{
  stylix.targets.neovim.enable = false;
  programs.neovim = {
    enable = true;

    /**
        Lazyvim setup with the follwing extras enabled:

        ● coding.blink  blink.cmp  friendly-snippets  blink.compat  catppuccin
        ● coding.yanky    yanky.nvim
        ● editor.harpoon2  harpoon
        ● editor.snacks_explorer    snacks.nvim
        ● editor.snacks_picker    nvim-lspconfig  snacks.nvim  alpha-nvim  dashboard-nvim  flash.nvim  mini.starter  todo-comments.nvim
        ● formatting.prettier  mason.nvim  conform.nvim  none-ls.nvim
        ● linting.eslint  nvim-lspconfig
        ● util.mini-hipatterns    mini.hipatterns

        ● lang.astro  lang.typescript  conform.nvim  nvim-lspconfig  nvim-treesitter
        ● lang.docker  mason.nvim  nvim-lspconfig  nvim-treesitter  none-ls.nvim  nvim-lint
        ● lang.json  SchemaStore.nvim  nvim-lspconfig  nvim-treesitter
        ● lang.markdown  markdown-preview.nvim  mason.nvim  nvim-lspconfig  render-markdown.nvim  conform.nvim  none-ls.nvim  nvim-lint
        ● lang.nix    nvim-lspconfig  nvim-treesitter  conform.nvim  nvim-lint
        ● lang.php  mason.nvim  neotest-pest  neotest-phpunit  nvim-lspconfig  nvim-treesitter  conform.nvim  neotest  none-ls.nvim  nvim-dap  nvim-lint
        ● lang.rust  crates.nvim  nvim-lspconfig  nvim-treesitter  rustaceanvim  mason.nvim  neotest
        ● lang.tailwind  nvim-lspconfig  tailwindcss-colorizer-cmp.nvim  nvim-cmp
        ● lang.toml  nvim-lspconfig
        ● lang.typescript  mason.nvim  mini.icons  nvim-lspconfig  mason-nvim-dap.nvim  nvim-dap
        ● lang.vue  lang.typescript  nvim-lspconfig  nvim-treesitter
        ● lang.yaml  SchemaStore.nvim  nvim-lspconfig
    */

    extraPackages = with pkgs; [
      # LazyVim
      lua-language-server
      # Telescope
      ripgrep
      # formatting
      nixfmt
      stylua
      statix
      prettier
      # mason
      astro-language-server
      docker-compose-language-service
      dockerfile-language-server
      hadolint
      lua-language-server
      markdown-toc
      markdownlint-cli2
      marksman
      shfmt
      tailwindcss-language-server
      taplo
      vtsls
      vue-language-server
      wgsl-analyzer
      yaml-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig =
      let
        # https://search.nixos.org/packages?channel=25.11&query=vimPlugins.
        plugins = with pkgs.vimPlugins; [
          # LazyVim
          LazyVim
          bufferline-nvim
          cmp-buffer
          cmp-nvim-lsp
          cmp-path
          cmp_luasnip
          conform-nvim
          dashboard-nvim
          dressing-nvim
          flash-nvim
          friendly-snippets
          gitsigns-nvim
          indent-blankline-nvim
          lualine-nvim
          neo-tree-nvim
          neoconf-nvim
          neodev-nvim
          noice-nvim
          nui-nvim
          nvim-cmp
          nvim-lint
          nvim-lspconfig
          nvim-notify
          nvim-spectre
          nvim-treesitter
          nvim-treesitter-context
          nvim-treesitter-textobjects
          nvim-ts-autotag
          nvim-ts-context-commentstring
          nvim-web-devicons
          persistence-nvim
          plenary-nvim
          telescope-fzf-native-nvim
          telescope-nvim
          todo-comments-nvim
          tokyonight-nvim
          trouble-nvim
          vim-illuminate
          vim-startuptime
          which-key-nvim
          {
            name = "LuaSnip";
            path = luasnip;
          }
          #{
          #  name = "catppuccin";
          #  path = catppuccin-nvim;
          #}
          {
            name = "mini.ai";
            path = mini-nvim;
          }
          {
            name = "mini.bufremove";
            path = mini-nvim;
          }
          {
            name = "mini.comment";
            path = mini-nvim;
          }
          {
            name = "mini.indentscope";
            path = mini-nvim;
          }
          {
            name = "mini.pairs";
            path = mini-nvim;
          }
          {
            name = "mini.surround";
            path = mini-nvim;
          }
          {
            name = "mini.icons";
            path = mini-nvim;
          }
          {
            name = "mini.hipatterns";
            path = mini-nvim;
          }
          {
            name = "mini.starter";
            path = mini-nvim;
          }
          SchemaStore-nvim
          # Mine
          vim-visual-multi
          diffview-nvim
          ts-comments-nvim
          # we have to rename to properly match with what lazyvim extras expects https://github.com/LazyVim/LazyVim/discussions/1972#discussioncomment-11326311
          {
            name = "harpoon";
            path = harpoon2;
          }
          nvim-dap
          mason-nvim-dap-nvim
          crates-nvim
          rustaceanvim
          neotest
          neotest-pest
          neotest-phpunit
          nvim-lint
          none-ls-nvim
          render-markdown-nvim
          markdown-preview-nvim
          snacks-nvim
          alpha-nvim
          todo-comments-nvim
          yanky-nvim
          blink-cmp
          friendly-snippets
          blink-compat
          grug-far-nvim
          lazydev-nvim
          # img-clip-nvim # for avante
          copilot-lua
        ];

        mkEntryFromDrv =
          drv:
          if lib.isDerivation drv then
            {
              name = "${lib.getName drv}";
              path = drv;
            }
          else
            drv;
        lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
      in
      ''
        require("lazy").setup({
          defaults = {
            lazy = true,
          },
          dev = {
            -- reuse files from pkgs.vimPlugins.*
            path = "${lazyPath}",
            patterns = { "" },
            -- fallback to download
            fallback = true,
          },
          spec = {
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- The following configs are needed for fixing lazyvim on nix
            -- force enable telescope-fzf-native.nvim
            { "nvim-telescope/telescope-fzf-native.nvim", enabled = true },
            -- disable mason.nvim, use programs.neovim.extraPackages
            { "mason-org/mason-lspconfig.nvim", enabled = false },
            { "mason-org/mason.nvim", enabled = false },
            -- import/override with your plugins
            { import = "plugins" },
            -- treesitter handled by xdg.configFile."nvim/parser", put this line at the end of spec to clear ensure_installed
            { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = {} } },
          },
        })
      '';
  };

  # https://github.com/nvim-treesitter/nvim-treesitter#i-get-query-error-invalid-node-type-at-position
  xdg.configFile."nvim/parser".source =
    let
      parsers = pkgs.symlinkJoin {
        name = "treesitter-parsers";
        paths =
          (pkgs.vimPlugins.nvim-treesitter.withPlugins (
            plugins: with plugins; [
              c
              typescript
              lua
              nix
              json
              markdown
              vue
              wgsl
              yaml
            ]
          )).dependencies;
      };
    in
    "${parsers}/parser";

  # Normal LazyVim config here, see https://github.com/LazyVim/starter/tree/main/lua
  xdg.configFile."nvim/lua".source = ./nvim/lua;
  xdg.configFile."nvim/lazyvim.json".source = ./nvim/lazyvim.json;
}
