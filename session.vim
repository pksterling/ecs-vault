let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
doautoall SessionLoadPre
silent only
silent tabonly
cd ~/notes
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess+=aoO
badd +9 archived/tasks-april.md
badd +7 in-use/riz-pipedrive-activity.md
badd +12 daily-notes/2026-05-15.md
badd +1 daily-notes/2026-06-10.md
badd +1 in-use/next-demo-slides.md
badd +13 in-use/side-quests.md
badd +1 daily-notes/2026-06-12.md
badd +2 archived/tasks-march.md
badd +15 in-use/tasks-current.md
badd +1 daily-notes/2026-06-03.md
badd +26 daily-notes/2026-06-15.md
badd +8 inbox/mileage-claim-approval-employee-portal.md
badd +9 inbox/planning-week-june-2026.md
badd +31 inbox/mini-kick-off-with-stefan.md
badd +19 daily-notes/2026-06-16.md
argglobal
%argdel
$argadd daily-notes/2026-06-03.md
edit daily-notes/2026-06-16.md
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 30 + 31) / 63)
exe 'vert 1resize ' . ((&columns * 107 + 108) / 216)
exe '2resize ' . ((&lines * 30 + 31) / 63)
exe 'vert 2resize ' . ((&columns * 107 + 108) / 216)
exe 'vert 3resize ' . ((&columns * 108 + 108) / 216)
argglobal
balt daily-notes/2026-06-15.md
setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
7
sil! normal! zo
let s:l = 19 - ((18 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 19
normal! 014|
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/in-use/tasks-current.md", ":p")) | buffer ~/notes/in-use/tasks-current.md | else | edit ~/notes/in-use/tasks-current.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/in-use/tasks-current.md
endif
balt ~/notes/daily-notes/2026-06-15.md
setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
9
sil! normal! zo
11
sil! normal! zo
let s:l = 15 - ((14 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 048|
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/inbox/mini-kick-off-with-stefan.md", ":p")) | buffer ~/notes/inbox/mini-kick-off-with-stefan.md | else | edit ~/notes/inbox/mini-kick-off-with-stefan.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/inbox/mini-kick-off-with-stefan.md
endif
balt ~/notes/inbox/planning-week-june-2026.md
setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
8
sil! normal! zo
9
sil! normal! zo
15
sil! normal! zo
22
sil! normal! zo
23
sil! normal! zo
27
sil! normal! zo
27
sil! normal! zo
let s:l = 8 - ((7 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 8
normal! 0
lcd ~/notes
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 30 + 31) / 63)
exe 'vert 1resize ' . ((&columns * 107 + 108) / 216)
exe '2resize ' . ((&lines * 30 + 31) / 63)
exe 'vert 2resize ' . ((&columns * 107 + 108) / 216)
exe 'vert 3resize ' . ((&columns * 108 + 108) / 216)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
