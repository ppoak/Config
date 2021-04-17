" ===== character painting ====={{{
" 
"      へ　　　　　／|
" 　　/＼7　　　 ∠＿/
" 　 /　│　　 ／　／
" 　│　Z ＿,＜　／　　 /`ヽ
" 　│　　　　　ヽ　　 /　　〉
" 　 Y　　　　　`　 /　　/
" 　ｲ●　､　●　　⊂⊃〈　　/
" 　()　 へ　　　　|　＼〈
" 　　>ｰ ､_　 ィ　 │ ／／
" 　 / へ　　 /　ﾉ＜| ＼＼
" 　 ヽ_ﾉ　　(_／　 │／／
" 　　7　　　　　　　|／
" 　　＞―r￣￣`ｰ―＿
" 
" 	    ppoak
" 
" ===== character painting =====}}}


" basic settings for neovim{{{
set nocompatible
filetype plugin on
filetype plugin indent on
set number
syntax on
set showmode
set showcmd
set encoding=utf-8
set fileencodings=utf-8,gbk,default,latin-1
set t_Co=256
set autoindent
set mouse=a
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set backspace=2
set nowrap
set pastetoggle=<F5>
set noerrorbells
set visualbell
set ignorecase
set smartcase
set hlsearch
set incsearch
set infercase
set cursorline
highlight cursorline cterm=NONE ctermbg=7 ctermfg=NONE
" set auto fold for vim type file
autocmd FileType vim :set foldmethod=marker
" set autosave while using <esc> or <c-[> for exiting insert mode works fine, mind that <c-c> was excluded for saving
" autocmd InsertLeave * :write

" settings for ctrl-p/n in command mode for switching between history command
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" set %% to expand full filename in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" set [b, [B, ]b, ]B for switching between buffers
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> ]B :blast<CR>

" set ctrl-i to eleminate highlight
nnoremap <silent> <C-I> :<C-u>nohlsearch<CR><C-I>
" set ctrl-g to summarize the occurance of the word under cursor
nnoremap <silent> <C-G> :<C-u>%s/<C-r><C-w>//gn<CR>

" set <C-C><C-C> to exit the terminal mode
tnoremap <C-c><C-c> <C-\><C-n>

" set <C-L> <C-H> to scroll horizontally half of the screen
nnoremap <silent> <C-L> zL
nnoremap <silent> <C-H> zH

" set * and # to search forward and backword for word in visually selected
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let temp = @s
    norm! gv"sy
    let @/='\V'.substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" set & to && in case of problem
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" set <space> to enter the commandline
nnoremap <space> :
vnoremap <space> :

" set <C-C><C-C> to exit the terminal mode
tnoremap <C-c><C-c> <C-\><C-n>

" remap global leader and make shortcuts
let g:mapleader="-"

" end of basic settings in neovim}}}


" settings for vim-plug{{{
" Download vim-plug:
" sh -c 'curl -fLo ${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim -create-dirs \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
call plug#begin(stdpath('data').'/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'Raimondi/delimitMate'
Plug 'jpalardy/vim-slime'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install' }
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Yggdroot/indentLine'

call plug#end()
" end of setting for vim-plug}}}


" settings for coc{{{
set updatetime=100
set hidden
set shortmess+=c
" always show the signcolumn, otherwise it would shift the text each time
if has("patch-8.1.1564")
    " recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=no
endif

" 设置tab进行代码自动补全
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" 设置<Enter>代码补全确认，使用`<C-g>u`取消
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
"设置`[g`和`]g`跳转到上一项和下一项的代码检查
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" 查看代码定义位置
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" 用K显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim', 'help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" 高亮显示光标下相同的字符
autocmd CursorHold * silent call CocActionAsync('highlight')
" 使用`\rn`进行变量重命名
nmap <leader>rn <Plug>(coc-rename)
" 使用`\f`对当前代码进行格式化
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" 设置代码折叠方式
augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" 设置选中代码部分可以进行的操作
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" 设置全部代码部分可以进行的操作
nmap <leader>ac <Plug>(coc-codeaction)
" 设置当前行代码进行自动更正
nmap <leader>qf  <Plug>(coc-fix-current)
" 设置文本类对象的映射
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" 设置Ctrl-s为文本选择快捷键
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" 设置coc自带的状态栏
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" 将`:Format`, `:Fold`, `:OR`命令添加到当前缓冲区, 用于格式化代码，折叠缓冲区，重排import语句
command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
" 设置CocList的快捷键
" 显示诊断
nnoremap <silent><nowait> <leader>a :<C-u>CocList diagnostics<cr>
" 显示插件
nnoremap <silent><nowait> <leader>e :<C-u>CocList extensions<cr>
" 显示命令
nnoremap <silent><nowait> <leader>c :<C-u>CocList commands<cr>
" 显示当前文档中的标志 
nnoremap <silent><nowait> <leader>o :<C-u>CocList outline<cr>
" 搜索工作区的标志
nnoremap <silent><nowait> <leader>S :<C-u>CocList -I symbols<cr>
" 对下一个项目执行默认动作
nnoremap <silent><nowait> <leader>j :<C-u>CocNext<cr>
" 对上一个项目执行默认动作
nnoremap <silent><nowait> <leader>k :<C-u>CocPrev<cr>
" 回复最新的CocList 
nnoremap <silent><nowait> <leader>p :<C-u>CocListResume<cr>
" 展开文件管理器
nnoremap <silent><nowait> <leader>b :CocCommand explorer<cr>
" translate word under the cursor
nnoremap <leader>t :CocCommand translator.popup<cr>

" vim自带插件matchit的启用
runtime macros/matchit.vim

" coc插件对其下的插件管理，将需要的coc插件加入下面的列表中
let g:coc_global_extensions = ['coc-json',
                            \ 'coc-vimlsp',
                            \ 'coc-marketplace',
                            \ 'coc-python',
                            \ 'coc-html',
                            \ 'coc-snippets',
                            \ 'coc-explorer',
                            \ 'coc-git',
                            \ 'coc-css',
                            \ 'coc-translator',
                            \ 'coc-emmet',
                            \ 'coc-tsserver']
" end of coc settings}}}


" settings for vim-slime{{{
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": "{last}"}
let g:slime_python_ipython = 1
" end of settings for vim-slime}}}


" settings for vim-surround{{{
autocmd FileType html let b:surround_45 = "/* \r */"
" end of settings for vim-surround}}}


" settings for less file convert on save{{{
" this feature need node-less support, before using it, install with 
" `sudo apt install node-less`
augroup LessFileConvert
    autocmd!
    autocmd BufWrite *.less :!lessc %% > %%.css
augroup END
" end of less autogroup}}}


" settings for markdown preview{{{
let g:mkdp_open_to_the_world = 1
let g:mkdp_open_ip = 'myownsitename'
let g:mkdp_port = 5500
function! g:EchoUrl(url) abort
    " 尝试定义一个打开浏览器函数执行的操作
    :echo a:url
endfunction
let g:mkdp_browserfunc = 'g:EchoUrl'
let g:mkdp_preview_options = {
\ 'mkit': {},
\ 'katex': {},
\ 'uml': {},
\ 'maid': {},
\ 'disable_sync_scroll': 0,
\ 'sync_scroll_type': 'relative',
\ 'hide_yaml_meta': 1,
\ 'sequence_diagrams': {},
\ 'flowchart_diagrams': {},
\ 'content_editable' : v:false 
\ }
let g:mkdp_page_title = '「${name}」'
" end of settings for markdown preview}}}


" settings for markdown shortcuts{{{
augroup MarkdownSettings
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown nnoremap k gk
    autocmd FileType markdown nnoremap j gj
    autocmd FileType markdown nnoremap $ g$
    autocmd FileType markdown nnoremap 0 g0
    autocmd FileType markdown nnoremap ^ g^
    autocmd Filetype markdown inoremap <buffer> ,w <Esc>/<++><CR>:nohlsearch<CR>"_c4l
    autocmd Filetype markdown inoremap <buffer> ,n ---<Enter><Enter>
    autocmd Filetype markdown inoremap <buffer> ,b ****<++><Esc>F*hi
    autocmd Filetype markdown inoremap <buffer> ,d ~~~~<++><Esc>F~hi
    autocmd Filetype markdown inoremap <buffer> ,i **<++><Esc>F*i
    autocmd Filetype markdown inoremap <buffer> ,c ``<++><Esc>F`i
    autocmd Filetype markdown inoremap <buffer> ,C ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
    autocmd Filetype markdown inoremap <buffer> ,t - [ ] 
    autocmd Filetype markdown inoremap <buffer> ,p ![](<++>) <++><Esc>F[a
    autocmd Filetype markdown inoremap <buffer> ,a [](<++>) <++><Esc>F[a
    autocmd Filetype markdown inoremap <buffer> ,1 #<Space><Enter><Enter><++><Esc>2kA
    autocmd Filetype markdown inoremap <buffer> ,2 ##<Space><Enter><Enter><++><Esc>2kA
    autocmd Filetype markdown inoremap <buffer> ,3 ###<Space><Enter><Enter><++><Esc>2kA
    autocmd Filetype markdown inoremap <buffer> ,4 ####<Space><Enter><Enter><++><Esc>2kA
    autocmd Filetype markdown inoremap <buffer> ,l <cr> --------<Enter>
augroup END
" end of settings for markdown shortcuts}}}


" setting for lightline{{{
let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'active': {
  \   'left': [
  \     [ 'mode', 'paste' ],
  \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method' ]
  \   ],
  \   'right':[
  \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
  \     [ 'blame' ]
  \   ],
  \ },
  \ 'component_function': {
  \   'blame': 'LightlineGitBlame',
  \ }
  \ }

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction
" setting for lightline}}}


" settings for indentLine{{{
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
" settings for indentLine}}}
