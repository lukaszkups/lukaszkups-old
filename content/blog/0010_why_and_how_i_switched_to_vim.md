---
kind: article
created_at: 4 February 2015
title: Why (and how) I've switched to vim
tags: ['blog']
---

#Why (and how) I've switched to vim

##Good & bad cop.

For the last couple years I was developing web apps using [Sublime Text](http://www.sublimetext.com/) exclusively. During that time I was also constantly monitoring code editors market and tried some of its newcomers (e.g. github's [atom](http://atom.io) or adobe's [brackets](http://brackets.io)), but in the long run I was always coming back to Sublime.

##Cool kids from the block

Besides old habits and laziness about learning new tool that should help me write code I was always curious about those oldschool, antique at the first look console editors like [emacs](https://www.gnu.org/software/emacs) or [vim](http://vim.org). There is something magical about these apps - all those badass hackers and world-class conference speakers are using it. Why?

##Back to the roots

Emacs and vim exist on the code editors scene for some time now. That means they are hardened in the (development) battle. You can find plugins for almost any task for code editor. Their simplicity means that they can launch in milliseconds. You can also pimp Your editor like a true gangsta and gain some respect in the neighbourhood. Advanced keymapping options will make Your fingers dance on the keyboard like John Travolta and Karen Lynn Gorner without getting saturday night fever.

##Coders just wanna have fun

The best thing about my job is that I love what I do, and it gives me tons of fun. I think it is the most important thing in (profession-side of) life - otherwise we'll be constantly depressed and do our job not so good as we're able to. 

In the earliest days of my carreer I had pleasure to work with awesome programmers who used vim as their main tool for code. At that day I was mainly focused to learn programming itself, rather than text editor usage - I think it would be a huge waste of time (especially that I was a beginner programmer). 

In my current job some programmers switched from their advanced IDEs to emacs. Their first days of work with new tool were quite funny - they make code many times slower than before, and have problems handling basic text editor operations :) After some time I've noticed significant improvement in their workflow - they're now coding as fast as in the days when they used their IDEs.
Now they have tools that  are easier to re-setup on every new machine they have to work on, and it uses much less their computer resources. These pros convinced me to give a shot and try something new. 

##First days of summer

I don't want to start next Text Editors (flame) War, so I'll tell why I've chosen vim over emacs: just because I could :) I've seen how coders are working with emacs and vim and vim's workflow is just more intuitive for me(I think it's very personal taste and/or style). 

At the moment of writing this sentence I have configured my vim on pretty advanced level - it works (almost) completely like I want it to work (only couple shortcuts are missing but before publishing this post I think my `.vimrc` file will be finished).

If You are curious where to start I can recommend [vimtutor](http://linuxcommand.org/man_pages/vimtutor1.html). It is an interactive, ~30minutes-long lesson which will learn You most of the vim fundamentals. It was the only source of information about vim, before I decided to switch (so You should probably try it right now).

I've configured my vim basing on my current needs - when I've found something really annoying or difficult I just googled how to customize/modify/remove it using `.vimrc` file & plugins.

##Ladies and gentleman..

So here's my complete `.vimrc` file (06/02/2015):

<pre>
<code class="bash">
"vundler config

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

"vim plugin list

Plugin 'gmarik/Vundle.vim'  "this is required for vim bundler
Plugin 'godlygeek/tabular   "really nice tool to align code'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'ervandew/supertab'   "code-completion using tab key
Plugin 'vim-scripts/Better-CSS-Syntax-for-Vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'godlygeek/csapprox'
Plugin 'scrooloose/nerdtree'
Plugin 'flazz/vim-colorschemes'
Plugin 'mattn/emmet-vim'
Plugin 'bling/vim-airline'
Plugin 'ofcapl/itg_flat_vim'

"vim configuration

autocmd vimenter * NERDTree
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set number
set t_Co=256
syntax enable
set autoindent
colorscheme itg_flat
set encoding=utf-8
set laststatus=2
set esckeys
set timeoutlen=1000 ttimeoutlen=0
set hidden
let g:airline#extensions#tabline#enabled=1
set guifont=Droid\ Sans\ Mono\for\ Powerline:h13
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif

"vim keymap

map tn :tabn<CR>
map tp :tabp<CR>
map <C-j> 10j
map <C-k> 10k
map <A-s> :w
nmap <Space> i
nnoremap <C-]><C-]> :bn<CR><Esc>
nnoremap <C-[><C-[> :bp<CR><Esc>
nnoremap <C-e> :Explore<CR>
nnoremap <C-[><C-]> <C-w><C-w>


</code>
</pre>


-- ł.
