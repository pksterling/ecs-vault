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
badd +12 in-use/current-tasks.md
badd +24 in-use/tcs-139a-claims-index.md
badd +1 daily-notes/2026-05-05.md
badd +31 in-use/set-goodjob-timezones.md
badd +21 inbox/riz-pipedrive-activity.md
badd +12 archived/charge-scheme-activities-for-evs.md
badd +22 daily-notes/2026-04-20.md
badd +12 in-use/tcs-139-employer-approvals.md
badd +51 daily-notes/2026-05-06.md
argglobal
%argdel
$argadd daily-notes/2026-05-05.md
edit in-use/tcs-139a-claims-index.md
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
wincmd _ | wincmd |
split
1wincmd k
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
exe '1resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 1resize ' . ((&columns * 89 + 89) / 179)
exe '2resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 179)
exe '3resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 3resize ' . ((&columns * 89 + 89) / 179)
exe '4resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 4resize ' . ((&columns * 89 + 89) / 179)
argglobal
enew
balt in-use/tcs-139a-claims-index.md
setlocal foldmethod=indent
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
lcd ~/notes
wincmd w
argglobal
balt ~/notes/daily-notes/2026-05-06.md
setlocal foldmethod=indent
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
11
sil! normal! zo
let s:l = 22 - ((15 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 22
normal! 027|
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/daily-notes/2026-05-06.md", ":p")) | buffer ~/notes/daily-notes/2026-05-06.md | else | edit ~/notes/daily-notes/2026-05-06.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/daily-notes/2026-05-06.md
endif
balt ~/notes/in-use/tcs-139-employer-approvals.md
setlocal foldmethod=indent
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
let s:l = 45 - ((19 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 45
normal! 06|
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/in-use/current-tasks.md", ":p")) | buffer ~/notes/in-use/current-tasks.md | else | edit ~/notes/in-use/current-tasks.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/in-use/current-tasks.md
endif
balt ~/notes/in-use/tcs-139-employer-approvals.md
setlocal foldmethod=indent
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
let s:l = 14 - ((13 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 14
normal! 0
lcd ~/notes
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 1resize ' . ((&columns * 89 + 89) / 179)
exe '2resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 179)
exe '3resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 3resize ' . ((&columns * 89 + 89) / 179)
exe '4resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 4resize ' . ((&columns * 89 + 89) / 179)
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
