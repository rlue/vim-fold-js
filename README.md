vim-fold-js
===========

This plugin provides automatic folding for JavaScript & TypeScript files (`*.js` / `*.ts`).

Applies folds to function and class declarations only.

### Before

```js
import invariant from 'shared/invariant';

import ReactNoopUpdateQueue from './ReactNoopUpdateQueue';

const emptyObject = {};
if (__DEV__) {
  Object.freeze(emptyObject);
}

/**
 * Base class helpers for the updating state of a component.
 */
function Component(props, context, updater) {
  this.props = props;
  this.context = context;
  // If a component has string refs, we will assign a different object later.
  this.refs = emptyObject;
  // We initialize the default updater but the real one gets injected by the
  // renderer.
  this.updater = updater || ReactNoopUpdateQueue;
}

Component.prototype.isReactComponent = {};
```

### After

```js
import invariant from 'shared/invariant';

import ReactNoopUpdateQueue from './ReactNoopUpdateQueue';

const emptyObject = {};
if (__DEV__) {
  Object.freeze(emptyObject);
}

/**
 * Base class helpers for the updating state of a component.
 */
- function Component ----------------------------------------------------- [7] -
Component.prototype.isReactComponent = {};
```

(Sample code lifted from [React](https://github.com/facebook/react).)

Installation
------------

There are lots of vim plugin managers out there. I like [vim-plug](https://github.com/junegunn/vim-plug).

Configuration
-------------

By default, vim-fold-js honors global fold settings
(_e.g.,_ `'foldenable'`, `'foldlevel'`, `'foldcolumn'`).
To override these settings and define special folding behavior for JS/TS files,
modify the appropriate lines below and add them to your `.vimrc`.

```viml
let g:fold_js_foldenable = 0          " disables folding (toggle with `zi`)
let g:fold_js_foldlevel = 2           " sets initial open/closed state of all folds (open unless nested more than two levels deep)
let g:fold_js_default_foldcolumn = 4  " shows a 4-character column on the lefthand side of the window displaying the document's fold structure
let g:fold_js_foldclose = 'all'       " closes folds automatically when the cursor is moved out of them (only applies to folds deeper than 'foldlevel')
let g:fold_js_foldminlines = 3        " disables closing of folds containing two lines or fewer
```

License
-------

The MIT License (MIT)

Copyright © 2017 Ryan Lue
