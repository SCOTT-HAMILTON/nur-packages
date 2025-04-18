{ MyVimConfig
, kotlin-vim
, vim-lsp
, vim-lsp-settings
, vim-myftplugins
, vim-stanza
, vim-super-retab
, vim-vala
, decisive-vim
}:
{ config, lib, pkgs, options, ... }:
with lib;
let
  cfg = config.programs.myvim;
  nixpkgs-unstable = import <nixpkgs-unstable> {};
  neovim-0_10 = nixpkgs-unstable.neovim-unwrapped;
in 
{
  options.programs.myvim = {
    enable = mkEnableOption "My vim config from https://github.com/SCOTT-HAMILTON/vimconfig";
    enableNvimCoc = mkEnableOption "Install neovim's coc.vim plugin";
  };
  config = mkIf cfg.enable (mkMerge ([
    ({
      programs.vim = {
        enable = true;
        extraConfig = builtins.readFile "${MyVimConfig}/vimrc";
        plugins = [
          pkgs.vimPlugins.vim-abolish
          pkgs.vimPlugins.commentary
          pkgs.vimPlugins.vim-colorschemes
          pkgs.vimPlugins.vim-qml
          kotlin-vim
          vim-lsp
          vim-lsp-settings
          vim-myftplugins
          vim-stanza
          vim-super-retab
          vim-vala
        ];
      };

      programs.neovim = {
        enable = true;
        # package = neovim-0_10;
        extraLuaConfig = ''

          vim.keymap.set('n', '<leader>cca', ":lua require('decisive').align_csv({})<cr>", {desc="align CSV", silent=true})
          vim.keymap.set('n', '<leader>ccA', ":lua require('decisive').align_csv_clear({})<cr>", {desc="align CSV clear", silent=true})
          vim.keymap.set('n', '<Left>', ":lua require('decisive').align_csv_prev_col()<cr>", {desc="align CSV prev col", silent=true})
          vim.keymap.set('n', '<Right>', ":lua require('decisive').align_csv_next_col()<cr>", {desc="align CSV next col", silent=true})

          -- setup text objects (optional)
          require('decisive').setup{}

          require('quarto').setup{
            debug = false,
            closePreviewOnExit = true,
            lspFeatures = {
              enabled = true,
              chunks = "curly",
              languages = { "r", "python", "julia", "bash", "html" },
              diagnostics = {
                enabled = true,
                triggers = { "BufWritePost" },
              },
              completion = {
                enabled = true,
              },
            },
            codeRunner = {
              enabled = true,
              default_method = "molten", -- "molten", "slime", "iron" or <function>
              ft_runners = {}, -- filetype to runner, ie. `{ python = "molten" }`.
              -- Takes precedence over `default_method`
              never_run = { 'yaml' }, -- filetypes which are never sent to a code runner
            },
          }
        '';
        extraConfig = let
          coc-config = ''
            " TextEdit might fail if hidden is not set.
            set hidden

            " Some servers have issues with backup files, see #649.
            set nobackup
            set nowritebackup

            " Give more space for displaying messages.
            " set cmdheight=2

            " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
            " delays and poor user experience.
            set updatetime=300

            " Don't pass messages to |ins-completion-menu|.
            set shortmess+=c

            " Always show the signcolumn, otherwise it would shift the text each time
            " diagnostics appear/become resolved.
            if has("nvim-0.5.0") || has("patch-8.1.1564")
              " Recently vim can merge signcolumn and number column into one
              set signcolumn=number
            else
              set signcolumn=yes
            endif

            " Use tab for trigger completion with characters ahead and navigate.
            " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
            " other plugin before putting this into your config.
            inoremap <silent><expr> <TAB>
                  \ pumvisible() ? "\<C-n>" :
                  \ CheckBackspace() ? "\<TAB>" :
                  \ coc#refresh()
            inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

            function! CheckBackspace() abort
              let col = col('.') - 1
              return !col || getline('.')[col - 1]  =~# '\s'
            endfunction

            " Use <c-space> to trigger completion.
            if has('nvim')
              inoremap <silent><expr> <c-space> coc#refresh()
            else
              inoremap <silent><expr> <c-@> coc#refresh()
            endif

            " Make <CR> auto-select the first completion item and notify coc.nvim to
            " format on enter, <cr> could be remapped by other vim plugin
            inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

            " Use `[g` and `]g` to navigate diagnostics
            " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
            nmap <silent> [g <Plug>(coc-diagnostic-prev)
            nmap <silent> ]g <Plug>(coc-diagnostic-next)

            " GoTo code navigation.
            nmap <silent> gd <Plug>(coc-definition)
            nmap <silent> gy <Plug>(coc-type-definition)
            nmap <silent> gi <Plug>(coc-implementation)
            nmap <silent> gr <Plug>(coc-references)

            " Use K to show documentation in preview window.
            nnoremap <silent> K :call ShowDocumentation()<CR>

            function! ShowDocumentation()
              if CocAction('hasProvider', 'hover')
                call CocActionAsync('doHover')
              else
                call feedkeys('K', 'in')
              endif
            endfunction

            " Highlight the symbol and its references when holding the cursor.
            autocmd CursorHold * silent call CocActionAsync('highlight')

            " Symbol renaming.
            nmap <F6> <Plug>(coc-rename)

            " Formatting selected code.
            xmap <leader>f  <Plug>(coc-format-selected)
            nmap <leader>f  <Plug>(coc-format-selected)

            augroup mygroup
              autocmd!
              " Setup formatexpr specified filetype(s).
              autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
              " Update signature help on jump placeholder.
              autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
            augroup end

            " Applying codeAction to the selected region.
            " Example: `<leader>aap` for current paragraph
            xmap <leader>a  <Plug>(coc-codeaction-selected)
            nmap <leader>a  <Plug>(coc-codeaction-selected)

            " Remap keys for applying codeAction to the current buffer.
            nmap <leader>ac  <Plug>(coc-codeaction)
            " Apply AutoFix to problem on the current line.
            nmap <leader>qf  <Plug>(coc-fix-current)

            " Run the Code Lens action on the current line.
            nmap <leader>cl  <Plug>(coc-codelens-action)

            " Map function and class text objects
            " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
            xmap if <Plug>(coc-funcobj-i)
            omap if <Plug>(coc-funcobj-i)
            xmap af <Plug>(coc-funcobj-a)
            omap af <Plug>(coc-funcobj-a)
            xmap ic <Plug>(coc-classobj-i)
            omap ic <Plug>(coc-classobj-i)
            xmap ac <Plug>(coc-classobj-a)
            omap ac <Plug>(coc-classobj-a)

            " Remap <C-f> and <C-b> for scroll float windows/popups.
            if has('nvim-0.4.0') || has('patch-8.2.0750')
              nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
              nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
              inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
              inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
              vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
              vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
            endif

            " Use CTRL-S for selections ranges.
            " Requires 'textDocument/selectionRange' support of language server.
            nmap <silent> <C-s> <Plug>(coc-range-select)
            xmap <silent> <C-s> <Plug>(coc-range-select)

            " Add `:Format` command to format current buffer.
            command! -nargs=0 Format :call CocActionAsync('format')

            " Add `:Fold` command to fold current buffer.
            command! -nargs=? Fold :call     CocAction('fold', <f-args>)

            " Add `:OR` command for organize imports of the current buffer.
            command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

            " Add (Neo)Vim's native statusline support.
            " NOTE: Please see `:h coc-status` for integrations with external plugins that
            " provide custom statusline: lightline.vim, vim-airline.
            set statusline^=%{coc#status()}%{get(b:,'coc_current_function',\'\')}

            " Mappings for CoCList
            " Show all diagnostics.
            nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
            " Manage extensions.
            nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
            " Show commands.
            nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
            " Find symbol of current document.
            nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
            " Search workspace symbols.
            nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
            " Do default action for next item.
            nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
            " Do default action for previous item.
            nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
            " Resume latest coc list.
            nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
          '';
          default-config = ''
            set number
            set laststatus=0
            let mapleader = ","

            vn < <gv
            vn > >gv
            ino fd <Esc>
            vno fd <Esc>

            set clipboard=unnamedplus
            colorscheme BlackSea

            " Let's save undo info!
            if !isdirectory($HOME."/.vim")
              call mkdir($HOME."/.vim", "", 0770)
            endif
            if !isdirectory($HOME."/.vim/undo-dir")
              call mkdir($HOME."/.vim/undo-dir", "", 0700)
            endif
            set undodir=~/.vim/undo-dir
            set undofile

            set expandtab
            set tabstop=2
            set shiftwidth=2
          '';
        in ''
          ${default-config}
          ${lib.optionalString cfg.enableNvimCoc coc-config}
        '';
        plugins = (optional cfg.enableNvimCoc pkgs.vimPlugins.coc-rust-analyzer)
        ++ [
          pkgs.vimPlugins.vim-nix
          pkgs.vimPlugins.vim-colorschemes
          pkgs.vimPlugins.commentary
          pkgs.vimPlugins.neovim-fuzzy
          pkgs.vimPlugins.polyglot
          pkgs.vimPlugins.quarto-nvim
          pkgs.vimPlugins.molten-nvim
          pkgs.vimPlugins.typst-vim
          vim-myftplugins
          decisive-vim
        ];
        viAlias = true;
      } // (lib.optionalAttrs cfg.enableNvimCoc {
        coc = {
          enable = true;
          settings = {
            powershell.powerShellExePath = "${pkgs.powershell}/bin/pwsh";
            powershell.integratedConsole.showOnStartup = false;
            clangd.path = "${pkgs.clang-tools}/bin/clangd";
            languageserver = {
              rust = {
                command = "rust-analyzer";
                filetypes = [ "rust" ];
                rootPatterns = [ "Cargo.toml" ];
              };
              nix = {
                command = "nil";
                filetypes = [ "nix" ];
                rootPatterns = [ "flake.nix" ];
              };
            };
          };
        };
      });
      home.packages = with pkgs; lib.optionals (cfg.enableNvimCoc) [
        nodejs
        rust-analyzer
        nil
      ];
    }
    )
  ]));
}
