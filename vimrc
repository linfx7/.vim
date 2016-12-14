"==========================================
" Author:  linfx7
" Version: 0.7
" Email: linfx7@gmail.com
" Last_modify: 2016-12-05
" Sections:
"       -> Pre-Settings
"       -> Initial Plugin
"       -> General Settings
"       -> HotKey Settings
"       -> Theme Settings
"       -> Custom Functions
"
"       -> 插件配置.vimrc_bundles中
"==========================================



"==========================================
" Pre-Settings
"==========================================

" 非兼容模式
set nocompatible

" 256色
" set t_Co=256

" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存  
set hidden

" 设置新文件的编码为 UTF-8
set encoding=utf-8
set langmenu=zh_CN.UTF-8

" 自动判断编码时，依次尝试以下编码：
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set helplang=cn

" 解决windows下如果encoding设置utf-8，菜单会乱码问题
if has("gui_running")
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif

"解决consle输出乱码
language message zh_CN.UTF-8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"==========================================
" Initial Plugin
"==========================================

filetype off

" 加载Vundle
if filereadable(expand("~/.vim/vimrc_bundles"))
    source ~/.vim/vimrc_bundles
endif

filetype plugin indent on


"==========================================
" General Settings
"==========================================

" 默认目录
if (argc() == 0)
    cd ~
else
    cd %:p:h
endif

" 设置窗口大小位置
if has("gui_running")
    set lines=45
    set columns=120
	winpos 350 100
endif

" 保存历史记录
set history=1000

" 记录光标位置
augroup resCur
    autocmd!
    autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" 开启语法高亮
syntax on

"显示行号
set number

"不要备份文件
set nobackup

"不要生成swap文件，当buffer被丢弃时隐藏它
setlocal noswapfile

" 突出显示当前行
"set cursorcolumn
set cursorline

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=5

"允许backspace正常处理indent eol start等
set backspace=2

" 跨行移动光标
set whichwrap=h,l,b,s,<,>,[,]

" 命令行（在状态行下）的高度，默认为1，这里是2
set laststatus=2

" 缩进配置
set smartindent

" tab相关变更
set tabstop=4     " 设置Tab键的宽度
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
set smarttab      " 按退格键时可以一次删掉 4 个空格
set shiftround    " 缩进时，取整
set expandtab     " 替换Tab为空格

" mintty中，在普通模式下和插入模式下使用不同光标
"let &t_ti.="\e[1 q"
"let &t_SI.="\e[5 q"
"let &t_EI.="\e[1 q"
"let &t_te.="\e[0 q"

" 取消自动注释
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"==========================================
" HotKey Settings
"==========================================

" 设置leader键
let mapleader = ','
let g:mapleader = ','

" buffer切换
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>f :bn<CR>

" <F5> 运行代码
map <F5> :call RunCode()<CR>

" <F2> 粘贴模式，取消自动缩进
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>


"==========================================
" Theme Settings
"==========================================

" Set extra options when running in GUI mode
if has("gui_running")
    set guifont=Hack:h10
    set guioptions-=m
    set guioptions-=T
    set guioptions-=L
endif

" theme主题
set background=dark
colorscheme molokai

"==========================================
" Custom Functions
"==========================================

" Run code
func! RunCode()  
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %< && ./%< && rm %<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< && ./%< && rm %<"
    elseif &filetype == 'python'
        exec "!python %"
    endif
endfunc

