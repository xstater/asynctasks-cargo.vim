function! s:is_win()
    if has("win32") || has("win64") || has("win16") || has("win95")
        return 1
    else
        return 0
    endif
endfunction

function! s:endl()
    if s:is_win()
        return "\r\n"
    else
        return "\n"
    endif
endfunction

function! s:separator()
    if s:is_win()
        return "\\"
    else
        return "/"
    endif
endfunction

" find the root of project
function! s:find_root()
    let l:cargo_toml = findfile('Cargo.toml',getcwd() . ';')
    if l:cargo_toml == ''
        return ''
    endif
    return fnamemodify(l:cargo_toml,':p:h')
endfunction

" get all exmaples
" return a list
function! s:get_examples(root)
    let l:examples_dir = a:root . '/examples'
    if isdirectory(l:examples_dir)
        return map(globpath(l:examples_dir,'*',0,1), 'fnamemodify(v:val,":t:r")')
    else
        return []
    endif
endfunction

function! s:gen_example_tasks(list)
    let l:raw_texts = []
    let l:endline = s:endl()
    for l:example in a:list
        let l:raw_texts += ["[cargo-example-" . l:example . "]"]
        let l:raw_texts += ["command = cargo run --example " . l:example]
        let l:raw_texts += ["root = <cwd>"]
        let l:raw_texts += [""]
    endfor
    return l:raw_texts
endfunction

function! s:write_to_file(file,raw_text)
    call writefile(a:raw_text,a:file,'')
endfunction

function! s:build_tasks()
    let l:root = s:find_root()
    if l:root == ''
        echo "no file will be generate"
        " Don't generate .task file if not rust project
        return 0
    endif
    echo "found root:" . l:root
    let l:exmaples = s:get_examples(l:root)
    let l:text = s:gen_example_tasks(l:exmaples)
    let l:separator = s:separator()
    let l:config_file = l:root . l:separator . g:asynctasks_config_name
    call s:write_to_file(l:config_file,l:text)
    echo l:config_file . " generated"
endfunction

command! ASTasksCargoBuild call s:build_tasks()
