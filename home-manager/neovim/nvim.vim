" Italicize comments
highlight Comment cterm=italic

" Enable relative line numbers by default
set number

" Default to 2 spaces for tabs
set shiftwidth=2

" Try local executable for node
let g:neoformat_try_node_exe = 1

" Rainbow
let g:rainbow_active = 1

" F# is filetype for .fs, .fsx, .fsi
autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

" Magma
let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "ueberzug"
" Not really sure how to set this with which-key
nnoremap <silent><expr> <LocalLeader>m nvim_exec('MagmaEvaluateOperator', v:true)
xnoremap <silent> <LocalLeader>m  :<C-u>MagmaEvaluateVisual<CR>
