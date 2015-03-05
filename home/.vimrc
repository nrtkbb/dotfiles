if !1 | finish | endif

if has('vim_starting')
  if &compatible
     set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" original repos on github
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'css3-syntax-plus'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'surround.vim'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'thinca/vim-poslist'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'tpope/vim-surround'
NeoBundle 'rosstimson/scala-vim-support'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'kana/vim-submode'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'alpaca-tc/alpaca_tags'
NeoBundle 'tpope/vim-rails'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'vim-scripts/rdark'

NeoBundleLazy 'OrangeT/vim-csharp', {
\   'autoload': { 'filetypes': [ 'cs', 'csi', 'csx' ] }
\ }

" vim-scripts repos
NeoBundle 'YankRing.vim'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

:source $VIMRUNTIME/macros/matchit.vim
let b:match_words = "if:endif,foreach:endforeach,\<begin\>:\<end\>"

" インデントを4にして、タブ文字は8文字のままにする（わざと崩れて表示させる）
set expandtab tabstop=8 shiftwidth=4
"set tabstop=4 shiftwidth=4 softtabstop=4

" 連続コピペ出来ない問題の解決
" http://qiita.com/items/bd97a9b963dae40b63f5
vnoremap <silent> <C-p> "0p<CR>

" ビープ音消す
set visualbell t_vb=

" 検索結果に移動したとき、その位置を画面の中央に
"nnoremap n nzz
"nnoremap N Nzz
"nnoremap * *zz
"nnoremap # #zz
"nnoremap g* g*zz
"nnoremap g# g#zz

" http://nanasi.jp/articles/vim/commentout_source.html
vmap ,# :s/^/#/<CR>:nohlsearch<CR>
vmap ,/ :s/^/\/\//<CR>:nohlsearch<CR>
vmap ,> :s/^/> /<CR>:nohlsearch<CR>
vmap ," :s/^/\"/<CR>:nohlsearch<CR>
vmap ,% :s/^/%/<CR>:nohlsearch<CR>
vmap ,! :s/^/!/<CR>:nohlsearch<CR>
vmap ,; :s/^/;/<CR>:nohlsearch<CR>
vmap ,- :s/^/--/<CR>:nohlsearch<CR>
vmap ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" wrapping comments
vmap ,* :s/^\(.*\)$/\/\* \1 \*\//<CR>:nohlsearch<CR>
vmap ,( :s/^\(.*\)$/\(\* \1 \*\)/<CR>:nohlsearch<CR>
vmap ,< :s/^\(.*\)$/<!-- \1 -->/<CR>:nohlsearch<CR>
vmap ,d :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>:nohlsearch<CR> 

" block comments
vmap ,b v`<I<CR><esc>k0i/*<ESC>`>j0i*/<CR><esc><ESC>
vmap ,h v`<I<CR><esc>k0i<!--<ESC>`>j0i--><CR><esc><ESC>

" place for backup files.
set backupdir=~/work/tmp
set directory=~/work/tmp

" NERDTree command
command NTT NERDTreeToggle
" NERDTree
nnoremap U :NERDTreeToggle<CR>
" 隠しファイルを表示
let NERDTreeShowHidden = 1

" expand path
cmap <c-x> <c-r>=expand('%:p:h')<cr>/
" expand file (not ext)
cmap <c-z> <c-r>=expand('%:p:r')<cr>

" コーディングスタイル定義
let s:coding_styles = {}
let s:coding_styles['default']      = 'set expandtab   tabstop=2 shiftwidth=2 softtabstop=2'
let s:coding_styles['dev']         = 'set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4'

command!
\   -bar -nargs=1 -complete=customlist,s:coding_style_complete
\   CodingStyle
\   execute get(s:coding_styles, <f-args>, '')

function! s:coding_style_complete(...) "{{{
    return keys(s:coding_styles)
endfunction "}}}

" デフォルトコーディングスタイル
nnoremap <Space>r :<C-u>execute "source " expand("%:p")<CR>

" Ctrl-A で数字をインクリメントするとき、先頭が 0 でも8進数として扱わない。
set nrformats-=octal

function! Caniuse()
  let s:line = getline(".")
  let s:css = substitute(substitute(substitute(getline("."), '^ *', "", "g" ), ':.*$', "", "g" ), '^-webkit-\|-moz-\|-ms-\|', "", "g" )
  "let s:css = matchstr( s:css , '[^ ]*[a-z-]*[^:]')
  echo s:line
  echo s:css
  if s:css != ""
    exec "!open \"http://caniuse.com/\\#search=" . s:css . "\""
  else
    echo "No CSS found in line."
  endif
endfunction

map <Leader>w :call Caniuse()<CR>

" poslist.vim settings.
map <C-o> <Plug>(poslist-prev-pos)
map <C-i> <Plug>(poslist-next-pos)
map <C-O> <Plug>(poslist-prev-buf)
map <C-I> <Plug>(poslist-next-buf)
let g:poslist_histsize = 1000

" ペーストしたテキストを選択する
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" YankRing.vim settings.
let g:yankring_history_dir = '~/work/tmp/'
let g:yankring_history_file = '.yankring_history'

" インデント変更しても選択を外れないように
vnoremap < <gv
vnoremap > >gv

let g:returnApp = "MacVim"

" for coffee-script
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h
setlocal splitright

function! s:Now()
  let now = "\n----------------------------------------------------------------------\n"
  let now = now . system("LANG=C date +'[%Y-%m-%d %H:%M:%S]'")
  execute ":normal i" . now
  execute ":startinsert"
endfunction
command! Now call s:Now()

function! s:Memo(diff)
  "edit `=system("memo_filename")`
  execute ":edit " . system("memo_filename " . a:diff)
endfunction
command! -nargs=0 Memo call s:Memo("")
command! -nargs=* Memox call s:Memo(<f-args>)

function! s:MemoEnter(argc)
  if a:argc == 0
    call s:Memo("")
    execute ":set filetype=markdown"
    execute ":cd %:h"
    execute ":NERDTreeCWD"
    execute ":wincmd \<C-W>"
  end
endfunction

" MacVimを開いた直後にその日のメモを開く
autocmd VimEnter * call s:MemoEnter(argc())

" markdownモードで勝手に折りたたまれるのをオフにする
let g:vim_markdown_folding_disabled=1

function! s:QL()
  let a = escape(expand("%:p"), " ()")
  let b = system("open -a MarkdownPreviewer.app " . a)
endfunction
command! QL call s:QL()

function! s:Memod()
  let a = escape(expand("%:h"), " ()")
  execute ":edit " . a
endfunction
command! Memod call s:Memod()

" ctags のファイルを現在の階層から下に続けて検索する
if has('path_extra')
  set tags+=./**4/tags;
  set tags+=tags;
endif

autocmd FileType git :setlocal foldlevel=99
"autocmd FileType git :setLocal Gitv_CommitStep=6
"autocmd FileType git :setLocal Gitv_OpenHorizontal=1

" vimgrep 後に自動で cwindow を開いてくれる魔法
autocmd QuickFixCmdPost *grep* cwindow

" [Qiita] Vimの便利な画面分割&タブページと、それを更に便利にする方法
" http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

let g:lightline = {
    \ 'colorscheme' : 'wombat',
    \ }

set t_Co=256

augroup AlpacaTags
  autocmd!
  if exists(':Tags')
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
    " 毎回保存と同時更新する場合はコメントを外す
    autocmd BufWritePost * TagsUpdate
  endif
augroup END

" https://github.com/scrooloose/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
