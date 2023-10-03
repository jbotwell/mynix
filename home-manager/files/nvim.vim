" Enable italic font rendering
if has('nvim')
  let &t_ZH = "\e[3m"
  let &t_ZR = "\e[23m"
else
  let &t_ZH = "\<Esc>[3m"
  let &t_ZR = "\<Esc>[23m"
endif

" Enable italics in the terminal
if !has('gui_running') && &t_Co >= 256
  " For 256-color terminals
  silent !echo -ne "\e]12;gray40\a"
endif

" Enable relative line numbers by default
set number

" Define a mapping to toggle between relative and absolute line numbers
nnoremap <silent> <C-n> :set relativenumber!<cr>

" undotree to leader u
nnoremap <Leader>u :UndotreeToggle<CR>

" make current file executable
nnoremap <Leader>x :!chmod +x %<CR>

set shiftwidth=2

" vim-astro with TypeScript
let g:astro_typescript = 'enable'

" NeoFormat
nnoremap <Leader>f :Neoformat<CR>
" Try local executable for node
let g:neoformat_try_node_exe = 1

" Rainbow
let g:rainbow_active = 1

" F# is filetype for .fs, .fsx, .fsi
autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

" Magma
nnoremap <expr> <LocalLeader>r nvim_exec('MagmaEvaluateOperator', v:true)
nnoremap <silent> <LocalLeader>rr :MagmaEvaluateLine<CR>
xnoremap <silent> <LocalLeader>r  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent> <LocalLeader>rc :MagmaReevaluateCell<CR>
nnoremap <silent> <LocalLeader>rd :MagmaDelete<CR>
nnoremap <silent> <LocalLeader>ro :MagmaShowOutput<CR>
nnoremap <silent> <LocalLeader>rq :noautocmd MagmaEnterOutput<CR>
let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "ueberzug"
