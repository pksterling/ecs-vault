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
badd +13 in-use/current-tasks.md
badd +1 in-use/tcs-139a-claims-index.md
badd +1 daily-notes/2026-05-05.md
badd +31 in-use/set-goodjob-timezones.md
badd +7 in-use/riz-pipedrive-activity.md
badd +12 archived/charge-scheme-activities-for-evs.md
badd +22 daily-notes/2026-04-20.md
badd +13 in-use/tcs-139-employer-approvals.md
badd +45 daily-notes/2026-05-06.md
badd +20 daily-notes/2026-05-07.md
badd +22 daily-notes/2026-05-08.md
badd +37 daily-notes/2026-05-11.md
badd +43 daily-notes/2026-05-12.md
badd +38 daily-notes/2026-05-13.md
badd +6 in-use/tcs-139d-claim-rejection.md
badd +16 daily-notes/2026-05-14.md
badd +1 daily-notes/2026-05-15.md
badd +113 in-use/next-demo-slides.md
badd +10 archived/investigate-reminder-email-error.md
badd +11 in-use/tcs-139b-view-claim.md
badd +24 daily-notes/2026-05-18.md
badd +6 in-use/tcs-139c-claim-approval.md
badd +8 permanent_notes/amend-incorrect-initial-odo-reading-snippet.md
badd +34 daily-notes/2026-05-20.md
badd +6 archived/upgrade-ruby-4-0-4.md
badd +5 in-use/vulnerability-scanner-issues.md
badd +28 daily-notes/2026-05-21.md
badd +6 archived/fix-net-imap-vulnerability.md
badd +9 in-use/side-quests.md
badd +7 permanent_notes/remove-gem-directories-in-dockerfile-snippet.md
badd +18805 ~/repos/ecs-calculator-app/.worktrees/employer-approvals-claim-index/db/structure.sql
badd +98 ~/repos/ecs-calculator-app/app/models/charge_scheme/contracts/can_onboard_quote.rb
badd +1 ~/repos/ecs-calculator-app/.worktrees/employer-approvals-claim-index/app/models/reimburse_scheme/reimburse_order.rb
badd +1 ~/repos/ecs-calculator-app/.worktrees/employer-approvals-claim-index/app/view_models/public/employers/mileage_claims_view_model.rb
badd +1 diffview:///panels/13/DiffviewFilePanel
badd +3 ~/repos/ecs-calculator-app/.git/worktrees/employer-approvals-claim-index/COMMIT_EDITMSG
badd +1 diffview://null
badd +528 ~/.dotfiles/.config/nvim/init.lua
badd +55 ~/repos/ecs-calculator-app/.worktrees/employer-approvals-claim-index/db/seeds/scenarios/reimburse_scheme_only_employer.rb
badd +6 in-use/reimburse-employer-approvals-issues.md
badd +23 daily-notes/2026-05-22.md
argglobal
%argdel
$argadd daily-notes/2026-05-05.md
edit daily-notes/2026-05-22.md
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
exe '1resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 1resize ' . ((&columns * 110 + 110) / 220)
exe '2resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 2resize ' . ((&columns * 110 + 110) / 220)
exe 'vert 3resize ' . ((&columns * 109 + 110) / 220)
argglobal
balt daily-notes/2026-05-21.md
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
let s:l = 23 - ((22 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 23
normal! 065|
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/in-use/current-tasks.md", ":p")) | buffer ~/notes/in-use/current-tasks.md | else | edit ~/notes/in-use/current-tasks.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/in-use/current-tasks.md
endif
balt ~/notes/in-use/riz-pipedrive-activity.md
setlocal foldmethod=indent
setlocal foldexpr=0
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=99
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldenable
let s:l = 16 - ((8 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 16
normal! 0
lcd ~/notes
wincmd w
argglobal
if bufexists(fnamemodify("~/notes/in-use/tcs-139b-view-claim.md", ":p")) | buffer ~/notes/in-use/tcs-139b-view-claim.md | else | edit ~/notes/in-use/tcs-139b-view-claim.md | endif
if &buftype ==# 'terminal'
  silent file ~/notes/in-use/tcs-139b-view-claim.md
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
let s:l = 11 - ((10 * winheight(0) + 33) / 67)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 11
normal! 0
lcd ~/notes
wincmd w
exe '1resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 1resize ' . ((&columns * 110 + 110) / 220)
exe '2resize ' . ((&lines * 33 + 34) / 69)
exe 'vert 2resize ' . ((&columns * 110 + 110) / 220)
exe 'vert 3resize ' . ((&columns * 109 + 110) / 220)
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
