" ==== start MyAutoCmd ====
" http://lambdalisue.hatenablog.com/entry/2013/06/23/071344
" releae autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする
set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" Swapファイル？Backupファイル？前時代的すぎなので全て無効化する
set nowritebackup
set nobackup
set noswapfile

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)
" ==== end ====

" ==== start other changes ====
" インデントを4にして、タブ文字は4文字のままにする
set expandtab tabstop=4 shiftwidth=4

" 連続コピペ出来ない問題の解決
" http://qiita.com/items/bd97a9b963dae40b63f5
vnoremap <silent> <C-p> "0p<CR>

" ビープ音消す
set visualbell t_vb=

" インデント変更しても選択を外れないように
vnoremap < <gv
vnoremap > >gv

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

" ペーストしたテキストを選択する
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" ==== end other changes ====

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

" place for backup files.
set backupdir=~/work/tmp
set directory=~/work/tmp

" NERDTree
nnoremap U :NERDTreeToggle<CR>
" 隠しファイルを表示
let NERDTreeShowHidden = 1

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

" YankRing.vim settings.
let g:yankring_history_dir = '~/work/tmp/'
let g:yankring_history_file = '.yankring_history'

let g:returnApp = "MacVim"

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
