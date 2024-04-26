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

" Smartcase
set ignorecase
set smartcase

" F# is filetype for .fs, .fsx, .fsi
autocmd BufNewFile,BufRead *.fs,*.fsx,*.fsi set filetype=fsharp

" Magma
let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "ueberzug"
" Not really sure how to set this with which-key
nnoremap <silent><expr> <LocalLeader>m nvim_exec('MagmaEvaluateOperator', v:true)
xnoremap <silent> <LocalLeader>m  :<C-u>MagmaEvaluateVisual<CR>

" Rainbow delimiters
let g:rainbow_delimiters = {
    \ 'strategy': {
        \ '': rainbow_delimiters#strategy.global,
        \ 'vim': rainbow_delimiters#strategy.local,
    \ },
    \ 'query': {
        \ '': 'rainbow-delimiters',
        \ 'lua': 'rainbow-blocks',
    \ },
    \ 'highlight': [
        \ 'RainbowDelimiterRed',
        \ 'RainbowDelimiterYellow',
        \ 'RainbowDelimiterBlue',
        \ 'RainbowDelimiterOrange',
        \ 'RainbowDelimiterGreen',
        \ 'RainbowDelimiterViolet',
        \ 'RainbowDelimiterCyan',
    \ ],
\ }

" Last yanked to system clipboard
nnoremap <silent> <LocalLeader>y :let @a=@+ \| let @+=@" \| let @"=@a<CR>

" use C-k to increment to avoid conflicts with tmux
nnoremap <C-k> <C-a>

" Remap & to apply to entire file
nnoremap & :%&&<CR>
xnoremap & :%&&<CR>
