" Beginners .vimrc
" v0.1 2012-10-22 Philip Thrasher
"
" Important things for beginners:
" * Start out small... Don't jam your vimrc full of things you're not ready to
"   immediately use.
" * Read other people's vimrc's.
" * Use a plugin manager for christ's sake! (I highly recommend vundle)
" * Spend time configuring your editor... It's important. Its the tool you
"   spend 8 hours a day crafting your reputation.
" * remap stupid things to new keys that make you more efficient.
" * Don't listen to the haters that complain about using non-default
"   key-bindings. Their argument is weak. I spend most of my time in the editor
"   on my computer, not others, so I don't care if customizing vim means I'll
"   have a harder time using remote vim.
"
" Below I've left some suggestions of good default settings to have in a bare
" minimal vimrc. You only what you want to use, and nothing more. I've heavily
" commented each, and these are what I consider bare necessities, my workflow
" absolutely depends on these things.
"
" If you have any questions, email me at pthrash@me.com
set nocompatible " Fuck VI... That's for grandpas.
filetype off

let g:vundle_default_git_proto = 'git'

set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath+=~/.vim/bundle/YouCompleteMe/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'alvan/vim-closetag'
Plugin 'git://github.com/godlygeek/tabular.git'
Plugin 'https://github.com/tpope/vim-surround.git'
Plugin 'https://github.com/tpope/vim-repeat.git'
Plugin 'https://github.com/tpope/vim-commentary.git'
Plugin 'https://github.com/kana/vim-textobj-user.git'
Plugin 'https://github.com/tkhren/vim-textobj-numeral.git'
Plugin 'glts/vim-textobj-comment.git'
Plugin 'kana/vim-textobj-function'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'vhdirk/vim-cmake'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'tell-k/vim-autopep8'
Plugin 'rhysd/vim-clang-format'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'
Plugin 'Chiel92/vim-autoformat'
Plugin 'junegunn/vim-easy-align'
Plugin 'panozzaj/vim-autocorrect'
Plugin 'StanAngeloff/php.vim'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'DoxygenToolkit.vim'
Plugin 'pixelneo/vim-python-docstring'
" Plugin 'zxqfl/tabnine-vim'
Plugin 'yycho0108/vim-toop'
Plugin 'yycho0108/DoxAlign.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
" We have to turn this stuff back on if we want all of our features.
"
syntax on " Syntax highlighting

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " use spaces instead of tabs.
set smarttab " let's tab key insert 'tab stops', and bksp deletes tabs.
set shiftround " tab / shifting moves to closest tabstop.
set autoindent " Match indents on new lines.
"set smartindent " Intellegently dedent / indent new lines based on rules.

" don't nag me when hiding buffers
set hidden " allow me to have buffers with unsaved changes.
set autoread " when a file has changed on disk, just load it. Don't ask.

" Make search more sane
set ignorecase " case insensitive search
set wildignorecase " Enable case insensitive search for filenames as well.
set smartcase " If there are uppercase letters, become case-sensitive.
set incsearch " live incremental searching
set showmatch " live match highlighting
set hlsearch " highlight matches
set gdefault " use the `g` flag by default.

" allow the cursor to go anywhere in visual block mode.
set virtualedit+=block

" leader is a key that allows you to have your own "namespace" of keybindings.
" You'll see it a lot below as <leader>
let mapleader = ","


" So we don't have to press shift when we want to get into command mode.
nnoremap ; :
vnoremap ; :

" create new vsplit, and switch to it.
noremap <leader>v <C-w>v

" bindings for easy split nav
" nnoremap <A-Up> <C-w>h
" nnoremap <A-Down> <C-w>j
" nnoremap <A-Left> <C-w>k
" nnoremap <A-Right> <C-w>l

" Clear match highlighting
noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Quick buffer switching - like cmd-tab'ing
nnoremap <leader><leader> <c-^>

" jump alias only because I can't remember <C-i> ...
noremap <leader>jl <C-i>
noremap <leader>jh <C-o>

" Visual line nav, not real line nav
" If you wrap lines, vim by default won't let you move down one line to the
" wrapped portion. This fixes that.
noremap j gj
noremap k gk

" Plugin settings:
" Below are some 'sane' (IMHO) defaults for a couple of the above plugins I
" referenced.

" Map the key for toggling comments with vim-commentary
nnoremap <leader>c <Plug>Commentary

nnoremap <leader>p :echo expand('%:p')<cr>

" Remap ctrlp to ctrl-t -- map it however you like, or stick with the
" defaults. Additionally, in my OS, I remap caps lock to control. I never use
" caps lock. This is highly recommended.
let g:ctrlp_map = '<c-t>'

" Let ctrlp have up to 30 results.
let g:ctrlp_max_height = 30

" Finally the color scheme. Choose whichever you want from the list in the
" link above (back up where we included the bundle of a ton of themes.)
"colorscheme elflord
set undofile

" Youcompleteme
let g:ycm_use_clangd = 1
" let g:ycm_clangd_binary_path = $HOME . "/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/clangd/output/bin/clangd"
let g:ycm_clangd_args = ["--completion-style=detailed"]
let g:ycm_server_python_interpreter= '/usr/bin/python3'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = $HOME . '/.vim/.ycm_extra_conf.py'
let g:ycm_goto_buffer_command = 'new-tab'
let g:ycm_log_level = 'debug'
let g:ycm_auto_hover = ''
let g:ycm_clangd_args=['--header-insertion=never', '--cross-file-rename']
nnoremap <leader>D <plug>(YCMHover)
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jD :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>ji :YcmCompleter GoToInclude<CR>
nnoremap <leader>x :YcmCompleter FixIt<Enter>
nnoremap <leader>s :YcmCompleter RefactorRename 

" Closetag
let g:closetag_filenames = '*.xml,*.html,*.xhtml,*.phtml,*.launch,*.world,*.config,*.sdf,*.xacro'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'

" Vim.CMake
let g:cmake_export_compile_commands = 1

autocmd BufNewFile,BufReadPost *.launch set filetype=xml
autocmd BufNewFile,BufReadPost *.world set filetype=xml
autocmd BufNewFile,BufReadPost *.config set filetype=xml
autocmd BufNewFile,BufReadPost *.sdf set filetype=xml
autocmd BufNewFile,BufReadPost *.urdf set filetype=xml
autocmd BufNewFile,BufReadPost *.xacro set filetype=xml

" TODO(yycho0108): I don't actually know what this does.
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Paste without Yank
"
" I haven't found how to hide this function (yet)
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

" NB: this supports "rp that replaces the selection by the contents of @r
vnoremap <silent> <expr> p <sid>Repl()
" Windows
" nmap <silent> <A-Up> :wincmd k<CR>
" nmap <silent> <A-Down> :wincmd j<CR>
" nmap <silent> <A-Left> :wincmd h<CR>
" nmap <silent> <A-Right> :wincmd l<CR>
set showcmd
set tabpagemax=100
" autocmd BufNewFile,BufRead * setlocal formatoptions-=c

set relativenumber

" Replace current word
nnoremap <leader>S :%s/\<<C-r><C-w>\>/
" Supported through jedi
autocmd FileType python nnoremap <leader>s :YcmCompleter RefactorRename 
" Supported through clangd
autocmd FileType cpp nnoremap <leader>s :YcmCompleter RefactorRename 

" default: execute 'current file'
nnoremap <leader>r :w \| term %:p<Enter>
" make an exception for python ...
autocmd FileType python nnoremap <leader>r :w \| !python3 %:p<Enter>
autocmd FileType cpp nnoremap <leader>r :w \| :CMake<Enter>

autocmd FileType cpp setlocal formatoptions=crql
autocmd FileType cuda setlocal formatoptions=crql

" formatter ...
" autocmd FileType python nnoremap <leader>f :Autopep8<Enter>
" autocmd FileType cpp nnoremap <leader>f :ClangFormat<Enter>
nnoremap <leader>f :Autoformat<Enter>
nnoremap <leader>x :YcmCompleter FixIt<Enter>

" override =
autocmd FileType python set equalprg=autopep8\ -


set backspace=indent,eol,start
" set splitbelow "vim 8.1 terminal setting

let g:formatdef_autopep8 = "'autopep8 - --ignore E402 --aggressive --experimental --range '.a:firstline.' '.a:lastline"
let g:autopep8_disable_show_diff=1
let g:autopep8_max_line_length=79

let g:formatdef_docformatter = "'docformatter - --range '.a:firstline.' '.a:lastline"
let g:formatters_python = ['autopep8', 'docformatter']
let g:run_all_formatters_python = 1

set wildmode=longest,list,full
set wildmenu
set ruler
set nowrap

" Format XML files nicely.
com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

" setlocal commentstring=//\ %s
autocmd FileType c,cpp,cs,java,php,cuda setlocal commentstring=//\ %s


" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>a <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>a <Plug>(EasyAlign)

set matchpairs+=<:>

" cmake-format configuration
let g:formatdef_my_cmake = '"cmake-format - --tab-size 2 --line-width 79"'
let g:formatters_cmake = ['my_cmake']

" JSON configuration
let g:formatdef_my_json = '"python3 -m json.tool"'
let g:formatters_json = ['my_json']

" Javascript configuration
let g:formatdef_my_javascript = '"js-beautify"'
let g:formatters_javascript = ['my_javascript']

let g:formatters_cuda = ['clangformat']
" let g:autoformat_verbosemode=1

" vim-sideways
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI

nmap <leader>h :SidewaysJumpLeft<cr>
nmap <leader>l :SidewaysJumpRight<cr>
nmap <leader>xh :SidewaysLeft<cr>
nmap <leader>xl :SidewaysRight<cr>

nmap <leader>d :Docstring<cr>

" DoxAlign
" call toop#mapFunction('DoxAlign', "<leader>da")"

set autochdir
autocmd VimLeave * call system("xsel -ib", getreg('+'))

command! Ctabs call s:Ctabs()
function! s:Ctabs()
  let files = {}
  for entry in getqflist()
    let filename = bufname(entry.bufnr)
    let files[filename] = 1
  endfor

  for file in keys(files)
    silent exe "tabedit ".file
  endfor
endfunction

" quickfixopenall.vim
"Author:
"   Tim Dahlin
"
"Description:
"   Opens all the files in the quickfix list for editing.
"
"Usage:
"   1. Perform a vimgrep search
"       :vimgrep /def/ *.rb
"   2. Issue QuickFixOpenAll command
"       :QuickFixOpenAll

function!   QuickFixOpenAll()
    if empty(getqflist())
        return
    endif
    let s:prev_val = ""
    for d in getqflist()
        let s:curr_val = bufname(d.bufnr)
        if (s:curr_val != s:prev_val)
            exec "edit " . s:curr_val
        endif
        let s:prev_val = s:curr_val
    endfor
endfunction

command! QuickFixOpenAll         call QuickFixOpenAll()
