# asynctasks-cargo.vim
A vim plugin that can auto generate tasks.ini from rust cargo project for asynctasks.vim

## Install
For vim-plug
```
Plug 'xstater/asynctasks-cargo.vim'
```

## Usage
This plugin need asynctasks.vim. To install asynctasks.vim, add these lines to 
your .vimrc/init.vim
```
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'
```
This plugin only provide a new command
```
:ASTasksCargoBuild
```
Execute this command will auto generate the task.ini file in your rust project.  
You can change this file by changing `g:asynctasks_config_name`.  
For my config
```
let g:asynctasks_config_name = '.git/tasks.ini'
```
Just throw this file to VCS directory, so it will not pollute your project.  
To automatically execute command when save buffer:
```
autocmd BufWrite * ASTasksCargoBuild
```
