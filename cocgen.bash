#!/usr/bin/env bash
#
# script that creates a file `install-coc-extensions.vim`
# Use this command to install it (coc.nvim plugin required):
#        vim -c 'source install-coc-extensions.vim'

echo "let g:coc_global_extensions = " > install-coc-extensions.vim
  jq '.dependencies | keys' ~/.config/coc/extensions/package.json | 
  sed "s/\"/'/g" | sed 's/^/  \\/g' >> install-coc-extensions.vim
