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
badd +14 in-use/current-tasks.md
badd +7 in-use/riz-pipedrive-activity.md
badd +12 daily-notes/2026-05-15.md
badd +1 ~/repos/ecs-calculator-app/.worktrees/employer-approvals-claim-index/app/view_models/public/employers/mileage_claims_view_model.rb
badd +1 diffview:///panels/13/DiffviewFilePanel
badd +2 daily-notes/2026-05-29.md
badd +11 inbox/tcs-139e-employee-resubmission.md
badd +30 daily-notes/2026-06-01.md
badd +19 inbox/tcs-139f-claim-filtering.md
badd +25 inbox/tcs-140-audit-log.md
badd +19 daily-notes/2026-06-02.md
badd +41 daily-notes/2026-06-03.md
badd +27 in-use/tcs-139d-claim-rejection.md
badd +1 in-use/tcs-139-employer-approvals.md
badd +1 archived/stefan-weekly-2026-04-01.md
badd +19 inbox/stefan-weekly-2026-06-03.md
argglobal
%argdel
$argadd daily-notes/2026-06-02.md
edit daily-notes/2026-06-03.md
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
exe '1resize ' . ((&lines * 19 + 21) / 42)
exe 'vert 1resize ' . ((&columns * 74 + 75) / 150)
exe '2resize ' . ((&lines * 20 + 21) / 42)
exe 'vert 2resize ' . ((&columns * 74 + 75) / 150)
exe 'vert 3resize ' . ((&columns * 75 + 75) / 150)
argglobal
balt inbox/stefan-weekly-2026-06-03.md
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
14
sil! normal! zo
19
sil! normal! zo
22
sil! normal! zo
25
sil! normal! zo
35
sil! normal! zo
let s:l = 41 - ((16 * winheight(0) + 9) / 19)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 41
normal! 016|
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/in-use/current-tasks.md", ":p")) | buffer ~/notes/in-use/current-tasks.md | else | edit ~/notes/in-use/current-tasks.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/in-use/current-tasks.md
endif
balt ~/notes/in-use/tcs-139-employer-approvals.md
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
12
sil! normal! zo
19
sil! normal! zo
22
sil! normal! zo
26
sil! normal! zo
40
sil! normal! zo
let s:l = 17 - ((11 * winheight(0) + 10) / 20)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 17
normal! 032|
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/inbox/tcs-139e-employee-resubmission.md", ":p")) | buffer ~/notes/inbox/tcs-139e-employee-resubmission.md | else | edit ~/notes/inbox/tcs-139e-employee-resubmission.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/inbox/tcs-139e-employee-resubmission.md
endif
balt ~/notes/in-use/current-tasks.md
setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
let s:l = 1 - ((0 * winheight(0) + 20) / 40)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 02|
lcd ~/notes
wincmd w
exe '1resize ' . ((&lines * 19 + 21) / 42)
exe 'vert 1resize ' . ((&columns * 74 + 75) / 150)
exe '2resize ' . ((&lines * 20 + 21) / 42)
exe 'vert 2resize ' . ((&columns * 74 + 75) / 150)
exe 'vert 3resize ' . ((&columns * 75 + 75) / 150)
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
