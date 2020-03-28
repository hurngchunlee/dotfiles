""" set syntax on
syntax on

""" enable hybrid number and relative line number
set number relativenumber

""" enable powerline vim
set laststatus=2
set t_Co=256
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
