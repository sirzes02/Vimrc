call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'rip-rip/clang_complete'
Plug 'cjuniet/clang-format.vim'
call plug#end()

"General configurations"""""""""
set encoding=UTF-8
set relativenumber
set autoindent
set cindent
set tabstop=4
set shiftwidth=2
set backspace=indent,eol,start
""""""""""""""""""""""""""""""""

"Clang configurations"""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_library_path='/usr/lib/llvm-6.0/lib/libclang-6.0.so.1' 
if has('nvim')
  inoremap <expr> <C-Space> "\<C-x>\<C-u>"
else
  inoremap <expr> <c-@> "\<C-x>\<C-u>" 
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"NERDTree configurations"""""""
let NERDTreeShowHidden=1
nmap <C-b> :NERDTreeToggle<CR>
map <A-Right> :tabn<cr>
map <A-Left> :tabp<cr>
"""""""""""""""""""""""""""""""

"Color configurations
colorscheme gruvbox
set bg=dark
"""""""""""""""""""""

"CtrlP configurations"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Airline configurations""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
"""""""""""""""""""""""""""""""""""""""""""""

"Commenter configurations"""""""""
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle
""""""""""""""""""""""""""""""""""

"Coc stuffs"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"With no messagen when vim starts
let g:coc_disable_startup_warning = 1

"Prettier configurations
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"global extensions declaration
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-css',
  \ ]

"Ctrl+Space to autocomplete
inoremap <silent><expr> <c-space> coc#refresh()

"Goto keys
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> f :CocCommand prettier.formatFile<cr>

"See the documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"Colors qhen select
autocmd CursorHold * silent call CocActionAsync('highlight')

"Remap for rename current word
nmap <F2> <Plug>(coc-rename)

"Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

"Format configurations
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

"Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

"Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
"Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

"Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

"Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

"Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

"Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"Using CocList
"Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Ctrl + Space configuration
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

