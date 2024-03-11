{ pkgs, ... }:
let
  username = "john";
  homeDirectory = "/home/${username}";
  configName = ".config";
  configHome = "${homeDirectory}/${configName}";
in {
  home.packages = with pkgs; [
    # language servers
    marksman
    rnix-lsp
    rust-analyzer
    nodePackages.vscode-json-languageserver-bin
    lua-language-server
    nodePackages.pyright
    nodePackages.typescript-language-server
    shellcheck

    # formatters
    clang-tools
    comrak
    luaformatter
    nixfmt
    nodePackages.prettier
    python310Packages.black
    rustfmt

    # debuggers
    netcoredbg
  ];

  programs.neovim = {
    enable = true;

    # use nvim instead of vi, vim, vimdiff
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraConfig = builtins.readFile (./neovim/nvim.vim);

    extraLuaConfig = builtins.readFile (./neovim/nvim.lua);

    plugins = with pkgs.vimPlugins; [
      # package management
      lazy-nvim
      packer-nvim

      # lsp/dev tools
      {
        plugin = neodev-nvim;
        type = "lua";
        config = ''
          require("neodev").setup {}
        '';
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          function add_lsp(binary, server, options)
              if vim.fn.executable(binary) == 1 then server.setup(options) end
          end
          add_lsp("tsserver", lspconfig.tsserver, {})
          add_lsp("rnix-lsp", lspconfig.rnix, {})
          add_lsp("marksman", lspconfig.marksman, {})
          add_lsp("rust-analyzer", lspconfig.rust_analyzer, {})
          add_lsp("lua-language-server", lspconfig.lua_ls, {})
          add_lsp("pyright", lspconfig.pyright, {})
          add_lsp("json-languageserver", lspconfig.jsonls,
                  {cmd = {"json-languageserver", "--stdio"}})
          add_lsp("csharp-ls", lspconfig.csharp_ls, {})
          add_lsp("fsautocomplete", lspconfig.fsautocomplete, {})
        '';
      }

      # keybindings set and help
      {
        plugin = which-key-nvim;
        type = "lua";
        config = ''
          local wk = require("which-key")
          local dapui = require("dapui")
          wk.register({
            c = {
              name = "ChatGPT",
              c = {"<cmd>ChatGPT<CR>", "ChatGPT"},
              e = {
                "<cmd>ChatGPTEditWithInstruction<CR>",
                "Edit with instruction",
                mode = {"n", "v"}
              },
              g = {
                "<cmd>ChatGPTRun grammar_correction<CR>",
                "Grammar Correction",
                mode = {"n", "v"}
              },
              t = {"<cmd>ChatGPTRun translate<CR>", "Translate", mode = {"n", "v"}},
              k = {"<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = {"n", "v"}},
              d = {"<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = {"n", "v"}},
              a = {"<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = {"n", "v"}},
              o = {
                "<cmd>ChatGPTRun optimize_code<CR>",
                "Optimize Code",
                mode = {"n", "v"}
              },
              s = {"<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = {"n", "v"}},
              f = {"<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = {"n", "v"}},
              x = {
                "<cmd>ChatGPTRun explain_code<CR>",
                "Explain Code",
                mode = {"n", "v"}
              },
              r = {
                "<cmd>ChatGPTRun roxygen_edit<CR>",
                "Roxygen Edit",
                mode = {"n", "v"}
              },
              l = {
                "<cmd>ChatGPTRun code_readability_analysis<CR>",
                "Code Readability Analysis",
                mode = {"n", "v"}
              }
            },
            t = {
              name = "Telescope",
              o = {"<cmd>Telescope oldfiles<CR>", "oldfiles", mode = {"n", "v"}},
              g = {"<cmd>Telescope live_grep<CR>", "live_grep", mode = {"n", "v"}},
              f = {"<cmd>Telescope fd<CR>", "fd", mode = {"n", "v"}},
              k = {"<cmd>Telescope keymaps<CR>", "keymaps", mode = {"n", "v"}},
              b = {"<cmd>Telescope buffers<CR>", "buffers", mode = {"n", "v"}},
              h = {"<cmd>Telescope help_tags<CR>", "help_tags", mode = {"n", "v"}}
            },
            L = {
              name = "LSP",
              g = {"<cmd>LspStart<CR>", "Start LSP", mode = {"n"}},
              k = {"<cmd>LspStop<CR>", "Stop LSP", mode = {"n"}},
              i = {"<cmd>LspInfo<CR>", "LSP Info", mode = {"n"}},
              r = {"<cmd>LspRestart<CR>", "Restart LSP", mode = {"n"}}
            },
            d = {
              name = "DAP",
              d = {dap.toggle_breakpoint, "Toggle Breakpoint", mode = {"n"}},
              c = {dap.continue, "Continue", mode = {"n"}},
              i = {dap.step_into, "Step Into", mode = {"n"}},
              s = {dap.step_over, "Step Over", mode = {"n"}},
              o = {dap.step_out, "Step Out", mode = {"n"}},
              r = {dap.repl.open, "Open REPL", mode = {"n"}},
              l = {dap.run_last, "Run Last", mode = {"n"}},
              p = {dap.pause, "Pause", mode = {"n"}},
              q = {dap.close, "Close", mode = {"n"}},
              e = {dap.disconnect, "Disconnect", mode = {"n"}},
              u = {dapui.toggle, "Toggle UI", mode = {"n"}}
            },
            n = {
              name = "Numbers",
              n = {"<cmd>set number!<CR>", "Toggle line numbers", mode = {"n"}},
              r = {
                "<cmd>set relativenumber!<CR>",
                "Toggle relative line numbers",
                mode = {"n"}
              }
            },
            m = {
              name = "Magma",
              m = {"<cmd>MagmaEvaluateLine<CR>", "Evaluate Line", mode = {"n"}},
              c = {"<cmd>MagmaReevaluateCell<CR>", "Reevaluate Cell", mode = {"n"}},
              d = {"<cmd>MagmaDelete<CR>", "Delete", mode = {"n"}},
              o = {"<cmd>MagmaShowOutput<CR>", "Show Output", mode = {"n"}},
              e = {
                "<cmd>noautocmd MagmaEnterOutput<CR>",
                "Enter Output",
                mode = {"n"}
              }
            },
            e = {"<cmd>NvimTreeToggle<CR>", "NvimTreeToggle", mode = {"n"}},
            u = {"<cmd>UndotreeToggle<CR>", "UndotreeToggle", mode = {"n"}},
            x = {"<cmd>!chmod +x %<CR>", "Make current file executable", mode = {"n"}},
            f = {"<cmd>Neoformat<CR>", "Neoformat", mode = {"n"}},
            w = {"<cmd>WhichKey<CR>", "WhichKey", mode = {"n"}},
          }, {prefix = "<leader>"})

          wk.register({
            ['<space>'] = {
              name = "Diagnostics and LSP",
              p = {vim.diagnostic.goto_prev, 'Go to previous', mode = {'n'}},
              n = {vim.diagnostic.goto_next, 'Go to next', mode = {'n'}},
              q = {vim.diagnostic.setloclist, 'Set Location List', mode = {'n'}},
              e = {vim.diagnostic.open_float, 'Open float', mode = {'n'}},
              t = {vim.lsp.buf.type_definition, 'type definition', mode = {'n'}},
              d = {vim.lsp.buf.declaration, 'declaration', mode = {'n', 'v'}},
              D = {vim.lsp.buf.definition, 'definition', mode = {'n', 'v'}},
              i = {vim.lsp.buf.implementation, 'implementation', mode = {'n', 'v'}},
              h = {vim.lsp.buf.hover, 'hover', mode = {'n', 'v'}},
              s = {vim.lsp.buf.signature_help, 'signature help', mode = {'n', 'v'}},
              r = {vim.lsp.buf.references, 'references', mode = {'n', 'v'}},
              wa = {
                vim.lsp.buf.add_workspace_folder,
                'add workspace folder',
                mode = {'n'}
              },
              wr = {
                vim.lsp.buf.remove_workspace_folder,
                'remove workspace folder',
                mode = {'n'}
              },
              wl = {
                vim.lsp.buf.list_workspace_folders,
                'list workspace folders',
                mode = {'n'}
              },
              rn = {vim.lsp.buf.rename, 'rename', mode = {'n'}},
              ca = {vim.lsp.buf.code_action, 'code action', mode = {'n', 'v'}}
            }
          })
        '';
      }

      # ai assistants
      {
        plugin = pkgs.unstable.vimPlugins.ChatGPT-nvim;
        type = "lua";
        config = ''
          require("chatgpt").setup ({
            api_key_cmd = "pass show openai",
            openai_params = {
              model = "gpt-4-1106-preview",
              frequency_penalty = 0,
              presence_penalty = 0,
              max_tokens = 1000,
              temperature = 0,
              top_p = 1,
              n = 1
            },
            openai_edit_params = {
              model = "gpt-4-1106-preview",
              frequency_penalty = 0,
              presence_penalty = 0,
              temperature = 0,
              top_p = 1,
              n = 1
            },
            chat = {keymaps = {cycle_windows = "<C-b>"}}
          })
        '';
      }
      pkgs.unstable.vimPlugins.copilot-vim

      # ui tools
      telescope-nvim
      {
        plugin = telescope-fzf-native-nvim;
        type = "lua";
        config = ''
          require('telescope').setup {
            extensions = {
              fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
              }
            }
          }
          -- To get fzf loaded and working with telescope, you need to call
          -- load_extension, somewhere after setup function:
          require('telescope').load_extension('fzf')
        '';
      }
      nui-nvim
      plenary-nvim
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup {
            view = {
              width = 60
            }
          }
        '';
      }

      # debugging
      nvim-dap
      {
        plugin = nvim-dap-ui;
        type = "lua";
        config = ''
          require("dapui").setup {}
        '';
      }
      nvim-dap-virtual-text
      {
        plugin = nvim-dap-python;
        type = "lua";
        config = ''
          -- see dap-python readme for this setup (not nix-y)
          require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
        '';
      }

      # syntax tools
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          -- treesitter recommended setup
          require'nvim-treesitter.configs'.setup {
              highlight = {
                  enable = true,
                  -- disable slow treesitter highlight for large files
                  disable = function(lang, buf)
                      local max_filesize = 100 * 1024 -- 100 KB
                      local ok, stats = pcall(vim.loop.fs_stat,
                                              vim.api.nvim_buf_get_name(buf))
                      if ok and stats and stats.size > max_filesize then
                          return true
                      end
                  end
              },
              -- set to false if you don't have `tree-sitter` CLI installed locally
              auto_install = false
          }
        '';
      }

      # On-the-spot evaluation; Jupyter-like
      magma-nvim-goose

      # More interactive tool
      {
        plugin = conjure;
        config = ''
          nnoremap L ,
          let g:conjure#mapping#prefix = ","
          let g:conjure#mapping#doc_word = "gk"
        '';
      }


      # Completions
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          -- nvim-cmp recommended setup
          local cmp = require("cmp")
          cmp.setup {
              formatting = {
                  format = require('lspkind').cmp_format({
                      mode = 'symbol', -- show only symbol annotations
                      maxwidth = 50, -- popup not to show more than maxwidth characters
                      ellipsis_char = '...' -- after maxwidth reached, show this ellipsis character
                  })
              },
              -- Same keybinds as vim's vanilla completion
              mapping = {
                  ['<C-n>'] = cmp.mapping.select_next_item({
                      behavior = cmp.SelectBehavior.Insert
                  }),
                  ['<C-p>'] = cmp.mapping.select_prev_item({
                      behavior = cmp.SelectBehavior.Insert
                  }),
                  ['<C-e>'] = cmp.mapping.close(),
                  ['<C-y>'] = cmp.mapping.confirm()
              },
              sources = {
                  {name = 'buffer', option = {get_bufnrs = vim.api.nvim_list_bufs}},
                  {name = 'nvim_lsp'}
              }
          }
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      lspkind-nvim

      # language specific
      {
        plugin = rust-tools-nvim;
        type = "lua";
        config = ''
          -- rust-tools recommended setup
          local rust_tools = require('rust-tools')
          if vim.fn.executable("rust-analyzer") == 1 then
              rust_tools.setup {tools = {autoSetHints = true}}
          end
          vim.api.nvim_set_hl(0, '@lsp.type.comment.rust', {})
        '';
      }
      vim-nix

      # sexp editing
      vim-parinfer
      {
      plugin = vim-sexp;
      config = ''
        let g:sexp_filetypes = 'clojure,lisp,scheme,racket,timl,hy,fennel'
      '';
      }

      # other misc
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup {}
        '';
      }
      pkgs.unstable.vimPlugins.rainbow-delimiters-nvim
      neoformat
      nvim-web-devicons
      vim-sneak
      vim-commentary
      vim-numbertoggle
      undotree
      vim-textobj-entire
      nvim-surround
      vim-unimpaired
    ];
  };
}
