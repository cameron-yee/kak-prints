declare-user-mode prints

provide-module prints-mode %{
    define-command comment-prints -docstring "toggle comments" %{
        declare-option str cl
        set-option buffer cl %val{cursor_line}

        execute-keys '%s<esc><a-s>s^[\s/]+(console.log|fmt.Print|println|System.out.println|echo)<ret>'
        execute-keys ': comment-line<ret>'
        execute-keys %opt{cl}
        execute-keys 'g<ret>'
    }

    define-command delete-prints -docstring "delete print statements" %{
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

map global prints c ':comment-prints<ret>' -docstring 'toggle commenting print statements'
map global prints d ':delete-prints<ret>' -docstring 'delete print statements'

