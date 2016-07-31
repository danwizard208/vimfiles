call NERDTreeAddKeyMap({
            \ 'key': 'dd',
            \ 'callback': 'DoneHandler',
            \ 'quickhelpText': 'Complete task under cursor',
            \ 'scope': 'DirNode' })
call NERDTreeAddKeyMap({
            \ 'key': 'S',
            \ 'callback': 'SelectHandler',
            \ 'quickhelpText': 'Select task under cursor (for moving)',
            \ 'scope': 'DirNode' })

function! DoneHandler(dirnode)
    let nerdTree = a:dirnode.getNerdtree()
    call a:dirnode.open()
    if len(a:dirnode.getDirChildren()) > 0
        echom "Can't complete a task with subtasks!"
        call a:dirnode.refresh()
        call nerdTree.render()
        return
    endif
    let todir_todo_root = g:NERDTreePath.New($TODIR_ROOT . "/todo")
    if ! a:dirnode.path.isUnder(todir_todo_root)
        echom "Task isn't in 'todo', not completing."
        call a:dirnode.refresh()
        call nerdTree.render()
        return
    endif
    try
        call a:dirnode.copy($TODIR_ROOT . "/done/")
        call a:dirnode.delete()
    catch /.*/
        echom "Exception while completing task:"
    endtry
    call nerdTree.render()
endfunction

let s:selectedTask = {}
function SelectHandler(dirnode)
    let s:selectedTask = dirnode
endfunction
