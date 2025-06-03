# home/fabric/programs/nixvim.nix
{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    diagnostic.settings = {
      enable = true;
      update_in_insert = true;
      severity_sort = true;

      # NOTE: Opt-in with 0.11
      virtual_text = {
        enable = true;
        severity.min = "warn";
        source = "if_many";
      };
      virtual_lines = {
        current_line = true;
      };

      float = {
        border = "rounded";
      };

      jump = {
        severity.__raw = "vim.diagnostic.severity.WARN";
      };

      signs = {
        text = {
          "__rawKey__vim.diagnostic.severity.ERROR" = "";
          "__rawKey__vim.diagnostic.severity.WARN" = "";
          "__rawKey__vim.diagnostic.severity.HINT" = "󰌵";
          "__rawKey__vim.diagnostic.severity.INFO" = "";
        };
        texthl = {
          "__rawKey__vim.diagnostic.severity.ERROR" = "DiagnosticError";
          "__rawKey__vim.diagnostic.severity.WARN" = "DiagnosticWarn";
          "__rawKey__vim.diagnostic.severity.HINT" = "DiagnosticHint";
          "__rawKey__vim.diagnostic.severity.INFO" = "DiagnosticInfo";
        };
      };
    };
    plugins = {
      hardtime.enable = true;
      avante = {
        enable = true;
        settings = {
          diff = {
            autojump = true;
            debug = false;
            list_opener = "copen";
          };
          highlights = {
            diff = {
              current = "DiffText";
              incoming = "DiffAdd";
            };
          };
          hints = {
            enabled = true;
          };
          mappings = {
            diff = {
              both = "cb";
              next = "]x";
              none = "c0";
              ours = "co";
              prev = "[x";
              theirs = "ct";
            };
            jump = {
              next = "]]";
              prev = "[[";
            };
          };
          provider = "ollama";
          auto_suggestions_provider = "ollama";
          ollama = {
            endpoint = "http://127.0.0.1:11434";
            model = "kirito1/qwen3-coder";
          };
          windows = {
            sidebar_header = {
              align = "center";
              rounded = true;
            };
            width = 30;
            wrap = true;
          };
        };
      };
      nvim-ufo.enable = true;
      render-markdown.enable = true;
      nui.enable = true;
      auto-session = {
        enable = true;
      };
      cmp-dictionary.enable = true;
      cmp-spell.enable = true;
      toggleterm = {
        enable = true;
        settings = {
          open_mapping = "[[<C-t>]]";
          direction = "float";
          insert_mappings = true;
          terminal_mappings = true;
          start_in_insert = true;
          persist_size = true;
          close_on_exit = true;
        };
      };
      web-devicons.enable = true;
      nix.enable = true;
      bufferline.enable = false;
      lualine.enable = true;
      luasnip.enable = true;
      yanky = {
        enable = true;
        settings = {
          highlight.timer = 150;
        };
      };
      ts-comments.enable = true;
      telescope = {
        settings = {
          pickers = {
            find_files = {
              hidden = true;
            };
          };
        };
        enable = true;
        keymaps = {
          "<leader> " = {
            action = "find_files";
          };
          "<leader>tl" = {
            action = "live_grep";
          };
          "<leader>td" = {
            action = "lsp_definitions";
          };
          "<leader>tr" = {
            action = "lsp_references";
          };
          "<leader>ti" = {
            action = "lsp_implementations";
          };
          "<leader>ts" = {
            action = "lsp_document_symbols";
          };
        };
        settings = {
          defaults = {
            file_ignore_patterns = [
              "^.git/"
              "^.mypy_cache/"
              "^__pycache__/"
              "^output/"
              "^data/"
              "%.ipynb"
              "^node_modules/"
              "^.next/"
              "^npm-debug.log"
              "^yarn-debug.log"
              "^yarn-error.log"
              "^.vercel/"
              "^.turbo/"
              "^build/"
              "^.DS_Store"
              "^.tailwindcss/"
              "^tailwind.config.js.backup"
              "%.css.map"
              "^styles/dist/"
              ".*_templ%.go$"
            ];
            hidden = true;

            mappings = {
              n = {
                # Normal mode mappings
                q = "close"; # Map 'q' to close the telescope window
              };
            };
          };
        };
      };
      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          auto_install = true;
          ensure_installed = [
            "bash"
            "c"
            "diff"
            "html"
            "javascript"
            "jsdoc"
            "json"
            "jsonc"
            "lua"
            "luadoc"
            "luap"
            "markdown"
            "markdown_inline"
            "printf"
            "python"
            "query"
            "regex"
            "toml"
            "tsx"
            "typescript"
            "vim"
            "vimdoc"
            "xml"
            "yaml"
          ];
        };
      };
      snacks = {
        enable = true;
      };
      indent-blankline.enable = true;
      harpoon = {
        enable = true;
        # keymaps = {
        #   addFile = "<leader>ha";
        #   toggleQuickMenu = "<C-e>";
        #   navFile = {
        #     "1" = "<leader>h;";
        #     "2" = "<leader>h,";
        #     "3" = "<leader>h.";
        #     "4" = "<leader>hp";
        #   };
        # };
      };
      yazi.enable = true;
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          current_line_blame_opts = {
            virt_text = true;
            virt_text_pos = "eol";
          };
          signcolumn = true;
          signs = {
            add = {
              text = "+";
            };
            change = {
              text = "▎";
            };
            changedelete = {
              text = "-";
            };
            delete = {
              text = "-";
            };
            topdelete = {
              text = "-";
            };
            untracked = {
              text = "!";
            };
          };
          watch_gitdir = {
            follow_files = true;
          };
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = ["alejandra"];
            markdown = ["dprint"];
            # Run on all files
            "_" = ["trim_whitespace" "trim_newlines"];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters = {
          };
          # Additional useful settings from the docs
          log_level = "warn";
          notify_on_error = true;
          notify_no_formatters = false;
        };
      };
      which-key.enable = true;
      undotree = {
        enable = true;
      };
      mini = {
        enable = true;
        modules = {
          pairs.enable = true;
          starter = {
            enable = true;
            header = ''
              ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
              ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
              ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
              ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
              ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
            '';
          };
          surround = {
            enable = true;
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
        };
      };
      todo-comments.enable = true;
      persistence.enable = true;
      friendly-snippets.enable = true;
      lsp = {
        enable = true;
        inlayHints = true;
        keymaps.lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
        };

        servers = {
          ts_ls.enable = true;
          eslint.enable = true;
          templ.enable = true;
          htmx.enable = true;
          nil_ls = {
            enable = true;
          };
          lua_ls = {
            enable = true;
            settings = {
              Lua = {
                hint = {
                  enable = true;
                  arrayIndex = "Enable";
                  setType = true;
                  paramName = "All";
                  paramType = true;
                };
              };
            };
          };
          tailwindcss.enable = true;
          gopls = {
            enable = true;
            settings = {
              hints = {
                enable = true;
                assignVariableTypes = true;
                compositeLiteralFields = true;
                compositeLiteralTypes = true;
                constantValues = true;
                functionTypeParameters = true;
                parameterNames = true;
                rangeVariableTypes = true;
              };
            };
          };
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            installRustfmt = true;
            settings = {
              inlayHints = {
                chainingHints.enable = true;
                closureReturnTypeHints.enable = "always";
                parameterHints.enable = true;
                typeHints.enable = true;
              };
            };
          };
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "path";}
            {name = "buffer";}
            {name = "luasnip";}
            {name = "dictionary";}
          ];
          mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<Tab>"] = cmp.mapping.confirm(),
                ["<Enter>"] = cmp.mapping.confirm(),
              })
            '';
          };
          preselect = "cmp.PreselectMode.Item";
          complition.completeopt = "menu,menuone";
        };
      };
      tmux-navigator.enable = true;
      vim-suda.enable = true;
    };
    extraPlugins = [
    ];
    extraConfigLua = ''
      vim.lsp.inlay_hint.enable(true)
      vim.filetype.add({
        extension = {
          cob = "cobweb",
          cobweb = "cobweb",
        },
      })
      local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
      parser_config.cobweb = {
        install_info = {
          url = "~/tree-sitter-cobweb", -- local path or git repo
          files = {"src/parser.c"},
          generate_requires_npm = false,
          requires_generate_from_grammar = false,
        },
        filetype = "cobweb",
      }
    '';
    globals.mapleader = " ";
    opts = {
      relativenumber = true;
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      wrap = false;
      cursorline = true;
      mouse = "a";
      clipboard = "unnamedplus";
      splitright = true;
      splitbelow = true;
      ignorecase = true;
      smartcase = true;
      termguicolors = true;
      signcolumn = "yes";
      scrolloff = 12;
      shada = "'1000,f1,<500,%";
      guicursor = "";
      colorcolumn = "80";
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ha";
        action.__raw = "function() require'harpoon':list():add() end";
        options.desc = "Harpoon add file";
      }
      {
        mode = "n";
        key = "<C-e>";
        action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
        options.desc = "Harpoon quick menu";
      }
      {
        mode = "n";
        key = "<leader>h;";
        action.__raw = "function() require'harpoon':list():select(1) end";
        options.desc = "Harpoon file 1";
      }
      {
        mode = "n";
        key = "<leader>h,";
        action.__raw = "function() require'harpoon':list():select(2) end";
        options.desc = "Harpoon file 2";
      }
      {
        mode = "n";
        key = "<leader>h.";
        action.__raw = "function() require'harpoon':list():select(3) end";
        options.desc = "Harpoon file 3";
      }
      {
        mode = "n";
        key = "<leader>hp";
        action.__raw = "function() require'harpoon':list():select(4) end";
        options.desc = "Harpoon file 4";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options = {
          desc = "Go to Left Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options = {
          desc = "Go to Lower Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options = {
          desc = "Go to Upper Window";
          remap = true;
        };
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options = {
          desc = "Go to Right Window";
          remap = true;
        };
      }

      # Window resizing
      {
        mode = "n";
        key = "<C-Up>";
        action = "<cmd>resize +2<cr>";
        options.desc = "Increase Window Height";
      }
      {
        mode = "n";
        key = "<C-Down>";
        action = "<cmd>resize -2<cr>";
        options.desc = "Decrease Window Height";
      }
      {
        mode = "n";
        key = "<C-Left>";
        action = "<cmd>vertical resize -2<cr>";
        options.desc = "Decrease Window Width";
      }
      {
        mode = "n";
        key = "<C-Right>";
        action = "<cmd>vertical resize +2<cr>";
        options.desc = "Increase Window Width";
      }
      {
        action = ":UndotreeToggle<CR>";
        key = "<leader>u";
        mode = ["n"];
      }
      {
        action = ":m '>+1<CR>gv=gv";
        key = "J";
        mode = ["v"];
      }
      {
        action = ":m '<-2<CR>gv=gv";
        key = "K";
        mode = ["v"];
      }
      {
        mode = "n";
        key = "<leader>sv";
        action = "<C-w>v";
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<C-w>s";
      }
      {
        mode = "n";
        key = "<leader>e";
        action = ":Yazi<CR>";
      }
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
      }
      {
        mode = "x";
        key = "<leader>p";
        action = "\"_dP";
      }
    ];
    colorschemes.rose-pine.enable = true;
  };
}
