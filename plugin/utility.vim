" Author: zy (elvestar@qq.com)

function! TrimProjectPath(file_path)
    let path_under_project = ''
    let tmp_path = a:file_path
    let length = len(tmp_path)

    while length > 0
        let pos = strridx(tmp_path, '/')
        let right_path = strpart(tmp_path, pos + 1, length)
        let tmp_path = strpart(tmp_path, 0, pos)
        let length = len(tmp_path)
        let path_under_project = right_path . '/' . path_under_project
        if finddir('.git', tmp_path) != ''
            break
        endif
    endwhile
    return  path_under_project
endfunction

function! GetFullPathForIncludeGuards()
    let dirname_under_root = expand("%:p:h")
    let dirname_under_project = TrimProjectPath(dirname_under_root)
    let dirname_for_include_guards = toupper(substitute(dirname_under_project, '/', '_', "g"))

    let filename = expand('%:t')
    let filename_for_include_guards = toupper(substitute(filename, '\.', '_', 'g')) . '_'

    let full_path_for_include_guards = dirname_for_include_guards . filename_for_include_guards
    let full_path_for_include_guards = substitute(full_path_for_include_guards, '-', '_', 'g')
    return full_path_for_include_guards
endfunction


" Get last class name in text
function! GetLastClassName()
    let pattern = 'class \(\w*\) '
    let linenum = search(pattern, 'Wnb')
    if linenum == 0
        return '${1}'
    else
        return matchlist(getline(linenum), pattern)[1]
    endif
endfunction

" TODO Uncompleted!
function! GetHeaderFile()
    let dirname = expand("%:p:h")
    let dirname = TrimProjectPath(dirname)
    let filename = split(expand("%:t"), '\.')[0]
    let header_file_path = dirname . filename . ".h"
    return header_file_path
endfunction

