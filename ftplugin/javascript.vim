let &l:foldmethod = 'expr'
let &l:foldexpr   = 'fold_js#foldexpr(v:lnum)'
let &l:foldtext   = 'fold_js#foldtext()'

if exists('g:fold_js_foldclose')
  let &l:foldclose = g:fold_js_foldclose
endif
if exists('g:fold_js_default_foldcolumn')
  let &l:foldcolumn  = g:fold_js_default_foldcolumn
endif
if exists('g:fold_js_foldenable')
  let &l:foldenable = g:fold_js_foldenable
endif
if exists('g:fold_js_foldlevel')
  let &l:foldlevel  = g:fold_js_foldlevel
endif
if exists('g:fold_js_foldminlines')
  let &l:foldminlines = g:fold_js_foldminlines
endif
