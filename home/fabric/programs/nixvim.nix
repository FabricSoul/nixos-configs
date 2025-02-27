# home/fabric/programs/nixvim.nix
{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    plugins = {
      cmp-dictionary.enable = true;
      cmp-spell.enable = true;
      toggleterm = {
        enable = true;
      };
      web-devicons.enable = true;
      nix.enable = true;
      bufferline.enable = true;
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
        enable = true;
        keymaps = {
          "<leader> " = {
            action = "git_files";
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
              "%.env"
              "%.env.local"
              "%.env.development.local"
              "%.env.test.local"
              "%.env.production.local"
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
            ];
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
        keymaps = {
          addFile = "<leader>ha";
          toggleQuickMenu = "<C-e>";
          navFile = {
            "1" = "<leader>h;";
            "2" = "<leader>h,";
            "3" = "<leader>h.";
            "4" = "<leader>hp";
          };
        };
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
            # Use prettierd first, fallback to prettier
            javascript = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            };
            typescript = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            };
            javascriptreact = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            };
            typescriptreact = {
              __unkeyed-1 = "prettierd";
              __unkeyed-2 = "prettier";
              stop_after_first = true;
            };
            css = ["prettier"];
            scss = ["prettier"];
            html = ["prettier"];
            json = ["prettier"];
            # Run on all files
            "_" = ["trim_whitespace" "trim_newlines"];
          };
          format_on_save = {
            timeout_ms = 500;
            lsp_fallback = true;
          };
          formatters = {
            prettier = {
              command = "prettier";
              args = [
                "--plugin=prettier-plugin-tailwindcss"
                "--print-width=80"
                "--tab-width=2"
                "--use-tabs=false"
                "--semi=true"
                "--single-quote=false"
                "--trailing-comma=es5"
                "--bracket-spacing=true"
              ];
            };
            # Optional: Add prettierd for faster formatting
            prettierd = {
              command = "prettierd";
              args = ["$FILENAME"];
            };
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
        servers = {
          ts_ls.enable = true;
          eslint.enable = true;
          nil_ls.enable = true;
          tailwindcss.enable = true;
          gopls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = true;
            installRustc = true;
            installRustfmt = true;
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

      # Toggleterm
      {
        mode = "n";
        key = "<leader>t";
        action = ":ToggleTerm direction=float<CR>";
      }
    ];
    colorschemes.rose-pine.enable = true;
  };
}
