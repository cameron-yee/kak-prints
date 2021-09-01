declare-user-mode prints

provide-module prints-mode %{
    define-command -docstring "toggle comments" \
    prints-mode-comment-prints %{
        declare-option str cl
        set-option buffer cl %val{cursor_line}

        execute-keys '%s<esc><a-s>s^[\s/]+(console.log|fmt.Print|println|System.out.println|echo)<ret>'
        execute-keys ': comment-line<ret>'
        execute-keys %opt{cl}
        execute-keys 'g<ret>'
    }

    define-command -docstring "delete print statements" \
    prints-mode-delete-prints %{
        declare-option int cl
        set-option buffer cl %val{cursor_line}
        
        # declare-option int sln
        # set-option buffer sln %val{buf_line_count}

        execute-keys '%s<esc><a-s>s^[\s/]+(console.log|fmt.Print|println|System.out.println|echo)<ret><a-x>d<ret><space>'
        
        # declare-option int fln
        # set-option buffer fln "-%val{buf_line_count}"

    	# declare-option int lndiff
    	# set-option buffer lndiff sln  
    	# set-option -add buffer lndiff fln
    	
        # cl = cl - (sln - fln)
        # set-option buffer cl execute-keys echo %sh{ echo $(expr $kak_opt_cl - ($kak_opt_sln - $kak_opt_fln))}
        
        execute-keys %opt{cl}
        execute-keys 'g<ret>'
    }
}

require-module prints-mode

map global prints c ': prints-mode-comment-prints<ret>' -docstring 'toggle commenting print statements'
map global prints d ': prints-mode-delete-prints<ret>' -docstring 'delete print statements'

