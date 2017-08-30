" Settings used by the default configuration of vim

" General settings:
autocmd FileType html,jinja,css,javascript,tasks,yaml setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python,fish setlocal expandtab shiftwidth=4 softtabstop=4

autocmd BufWritePre * StripWhitespace

" Maximum comment length ruler for Python
let &colorcolumn=72

" Plugin-related settings:
autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

" CTRL-t to toggle tree view
nmap <silent> <C-t> :NERDTreeToggle<CR>
" Set F2 to put the cursor to the nerdtree
nmap <silent> <F2> :NERDTreeFind<CR>

call deoplete#enable()
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
let deoplete#sources#jedi#show_docstring = 1

let g:neomake_python_pylama_maker = {
      \ 'exe': 'pylama',
      \ 'args': ['--format', 'pep8', '--linters',
      \ 'pydocstyle,pycodestyle,pylint,pyflakes,mccabe', '--ignore',
      \ 'D203,D213'],
      \ 'errorformat': neomake#makers#ft#python#pylama()['errorformat'],
      \ }
autocmd! BufWritePost * Neomake
