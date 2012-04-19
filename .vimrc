filetype plugin on
set showtabline=2

set tabstop=4
set shiftwidth=4
set smarttab
"set expandtab
set autoindent
set smartindent

set foldenable
set foldmethod=manual
set foldmarker={,}
set foldcolumn=1
set incsearch
set hlsearch

set backup

" сохранять умные резервные копии ежедневно
function! BackupDir()
" определим каталог для сохранения резервной копии
let l:backupdir=$HOME.'/.vim/backup/'.
        \substitute(expand('%:p:h'), '^'.$HOME, '~', '')

" если каталог не существует, создадим его рекурсивно
    if !isdirectory(l:backupdir)
    call mkdir(l:backupdir, 'p', 0700)
endif

   " переопределим каталог для  резервных копий
let &backupdir=l:backupdir
   " переопределим расширение файла резервной копии
let &backupext=strftime('~%Y-%m-%d_%H-%M~')
endfunction

" выполним передзаписью буффера надиск
autocmd! bufwritepre *
call BackupDir()

"set number
"set t_Co=256
"colorscheme calmar256-dark
"colo xterm16
set makeprg=/usr/share/vim/current/tools/efm_perl.pl\ -c\ %\ $*


syntax on
colorscheme murphy

set fileencodings=utf-8,koi8-r
set fileformats=unix,dos,mac
