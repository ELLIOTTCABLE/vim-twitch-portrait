if exists('g:loaded_twitch_portrait')
  finish
endif
let g:loaded_twitch_portrait = v:true

command! -nargs=0 ResetPortrait call ResetPortrait()
command! -nargs=0 CreatePortrait call CreatePortrait()

function ResetPortrait()
   let l:win = bufwinnr('cmatrix')
   if -1 == l:win
      echom "ResetPortrait: Portrait-window not found, re-creating"
      call CreatePortrait()
   else
      let l:prev = winnr()
      let l:view = winsaveview()

      " FIXME: This will bungle the arrangement if a second, lower window is open
      exe l:win 'wincmd w'
      wincmd H
      exe '54wincmd |'
      setl winfixheight winfixwidth

      exe l:prev 'wincmd w'
      call winrestview(l:view)
   endif
endfunction

function CreatePortrait()
   let l:prev = winnr()
   let l:view = winsaveview()

   " TODO: ensure user's windows don't move either before *or after* this
   let l:equalalways = &equalalways
   if l:equalalways
      set noequalalways
   endif

   aboveleft vsplit
   wincmd H
   setl winfixheight winfixwidth

   terminal cmatrix -a -b -C blue
   exe "54wincmd |"

   " FIXME: This isn't switching back into Normal mode????????????//??//NEHIdnswiarttoieas/nn?
   exe "normal \<C-\>\<C-N>"

   if l:equalalways
      set equalalways
   endif

   exe (l:prev + 1) "wincmd w"
   call winrestview(l:view)
endfunction
