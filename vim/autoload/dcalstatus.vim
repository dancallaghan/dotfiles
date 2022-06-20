scriptencoding utf-8

" ============================================================================
" Utility
" ============================================================================

" @return {String}
function! dcalstatus#IsNonFile() abort
  return getbufvar(s:bufnr, '&buftype') =~# '\v(nofile|quickfix|terminal)'
endfunction

" @return {String}
function! dcalstatus#IsHelp() abort
  return getbufvar(s:bufnr, '&buftype') =~# '\v(help)'
endfunction

" ============================================================================
" Status line
" ============================================================================

" Called by autocmd in vimrc, refresh statusline in each window
function! dcalstatus#Refresh() abort
  for l:winnr in range(1, winnr('$'))
    let l:fn = '%!dcalstatus#Output(' . l:winnr . ')'
    call setwinvar(l:winnr, '&statusline', l:fn)
  endfor
endfunction

" a:winnr from dcalstatus#Refresh() or 0 on set statusline
function! dcalstatus#Output(winnr) abort
  let s:winnr = a:winnr
  let s:bufnr = winbufnr(a:winnr)
  let s:ww    = winwidth(a:winnr)
  let l:contents = ''

  " ==========================================================================
  " Left side
  " ==========================================================================

  " Filebased
  "let l:contents .= '%h%q%w'     " [help][Quickfix/Location List][Preview]
  let l:contents .= '%#StatusLine#' . dcalstatus#Filetype()
  let l:contents .= '%#PmenuSel#' . dcalstatus#Filename()
  let l:contents .= '%#Todo#' . dcalstatus#Dirty()
  let l:contents .= '%#StatusLine#' . dcalstatus#GitBranch()

  " Toggleable
  let l:contents .= '%#DiffText#' . dcalstatus#Paste()

  let l:contents .= '%#Error#' . dcalstatus#Readonly()

  " ==========================================================================
  " Right side
  " ==========================================================================

  " Instance context
  let l:contents .= '%*%='
  let l:contents .= '%<'
  let l:contents .= '%#PmenuSel#' . dcalstatus#ShortPath()
  let l:contents .= '%#StatusLine#' . dcalstatus#Ruler()

  return l:contents
endfunction

" @return {String}
function! dcalstatus#Paste() abort
  return s:winnr != winnr() || empty(&paste)
        \ ? ''
        \ : ' ᴘ '
endfunction

" @return {String}
function! dcalstatus#Readonly() abort
  return getbufvar(s:bufnr, '&readonly') ? ' ʀ ' : ''
endfunction

" @return {String}
function! dcalstatus#Filetype() abort
  let l:ft = getbufvar(s:bufnr, '&filetype')
  return empty(l:ft)
        \ ? ''
        \ : ' ' . l:ft . ' '
endfunction

" @return {String}
function! dcalstatus#Filename() abort
  if dcalstatus#IsNonFile()
    return ''
  endif

  let l:contents = ' %.64f'
  let l:contents .= isdirectory(expand('%:p')) ? '/ ' : ' '
  return l:contents
endfunction

" @return {String}
function! dcalstatus#Dirty() abort
  return getbufvar(s:bufnr, '&modified') ? ' + ' : ''
endfunction

" @return {String}
function! dcalstatus#ShortPath() abort
  if s:ww < 80
        \ || dcalstatus#IsNonFile()
        \ || dcalstatus#IsHelp()
    return ''
  endif

  let l:full = fnamemodify(getcwd(), ':~:.')
  return len(l:full) > s:ww
        \ ? ''
        \ : ' ' . (len(l:full) == 0 ? '~' : l:full) . ' '
endfunction

" Uses fugitive or gita to get cached branch name
"
" @return {String}
function! dcalstatus#GitBranch() abort
  return s:ww < 80 || s:winnr != winnr()
        \ || dcalstatus#IsNonFile()
        \ || dcalstatus#IsHelp()
        \ ? ''
        \ : ' ' . FugitiveStatusline() . ' '
endfunction

" @return {String}
function! dcalstatus#Ruler() abort
  return ' %5l : %-4c '
endfunction
