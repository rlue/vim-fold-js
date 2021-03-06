" Public Functions =============================================================
function! fold_js#foldexpr(lnum)
  if s:a_declaration_opens_on(a:lnum)
    return 'a1'
  elseif !s:blank(a:lnum + 1) && s:a_declaration_closes_on(prevnonblank(a:lnum))
    return 's1'
  else
    return '='
  endif
endfunction

function! fold_js#foldtext()
  let s:line = getline(v:foldstart)
  let s:preview_maxwidth = 80 - 1 - (strdisplaywidth(s:stats())) - 2

  let s:preview = s:format_method_signature(s:line)[0:(s:preview_maxwidth - 1)]
  let s:preview = substitute(s:preview, '^\( *\)  ', '\1- ', '')

  let s:padding = repeat('-', s:preview_maxwidth - strdisplaywidth(s:preview) + 1)
  let s:padding = substitute(s:padding, '\(^.\|.$\)', ' ', 'g')

  return s:preview . s:padding . s:stats() . ' -'
endfunction

" Helper Functions =============================================================

" foldexpr ---------------------------------------------------------------------
function! s:a_declaration_opens_on(lnum)
  return (getline(a:lnum) =~ s:declaration_heading_regex('function')) ||
        \ (getline(a:lnum) =~ s:declaration_heading_regex('class'))
endfunction

function! s:declaration_heading_regex(construct)
  if !exists('s:constructs')
    let s:constructs = { 'function': '(export (default )=)=function \w+(\<[^>]+\>)=\(',
          \              'class': '(export (default )=)=class \w+ \{' }
  endif

  return '\v^\s*' . s:constructs[a:construct] " . 'line suffix?'
endfunction

function! s:a_declaration_closes_on(lnum)
  if !s:a_body_closes_on(a:lnum)
    return 0
  endif

  let l:cursor_bookmark = getcurpos()
  call cursor(a:lnum, 1)
  let l:body_start = searchpair('{', '', '}', 'bW')
  if getline('.') =~ '(.*).*{'
    let l:declaration_heading = l:body_start
  elseif getline('.') =~ ').*{'
    call cursor(0, 1)
    let l:declaration_heading = searchpair('(', '', ')', 'bW')
  else
    let l:declaration_heading = 0
  endif
  call setpos('.', l:cursor_bookmark)

  return s:a_declaration_opens_on(l:declaration_heading)
endfunction

function! s:a_body_closes_on(lnum)
  return getline(a:lnum) =~ '^\s*\}$'
endfunction

function! s:blank(lnum)
  return getline(a:lnum) =~ '^\s*$'
endfunction

" foldtext ---------------------------------------------------------------------

function! s:stats()
  let l:inner_declaration = range(v:foldstart + 1, prevnonblank(v:foldend) - 1)

  " don't count non-content lines or comments
  call filter(l:inner_declaration, "getline(v:val) !~# '^\\(\\W*$\\|\\s*//\\)'")
  return '[' . len(l:inner_declaration) . ']'
endfunction

function! s:format_method_signature(str)
  if a:str =~ '(.*)'
    return substitute(a:str, ')\zs.*$', '', '')
  elseif a:str =~ '(\s*$'
    return substitute(a:str, '(\s*$', '(...)', '')
  else
    return a:str
  end
endfunction
