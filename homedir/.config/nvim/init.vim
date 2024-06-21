" Followed by `:help nvim-from-vim`
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

set clipboard+=unnamedplus
highlight Folded guifg=#444444
highlight ColorColumn guibg=#242424
highlight DiffAdd guibg=Black
highlight DiffChange guibg=Black
