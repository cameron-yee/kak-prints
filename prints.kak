declare-user-mode prints

declare-option str current_line

provide-module prints-mode %{
    define-command -docstring "toggle comments" \
    prints-mode-comment-prints %{
        set-option buffer current_line %val{cursor_line}

        execute-keys '%s<esc><a-s>s^[\s/]+(console\.log|fmt\.Print|println|System\.out\.println|echo)<ret>'
        execute-keys ': comment-line<ret>'
        execute-keys %opt{current_line}
        execute-keys 'g<ret>'
    }

    define-command -docstring "delete print statements" \
    prints-mode-delete-prints %{
        set-option buffer current_line %val{cursor_line}

		# execute-keys will throw an error if no matches are found for the search
		try %{
    		execute-keys '<esc>Ggs^[\s/]+(console\.log|fmt\.Print|println|System\.out\.println|echo)<ret>'
		}

        eval %sh{
        	selections="$kak_reg_hash"
        	deleted_lines_before_current_line=$(echo "$selections" | rev | cut -d' ' -f 1 | rev)
        	
        	# this will jump the cursor up one line if there are no print statements before the cursor because
        	# the minimum of $kak_reg_hash is 1
    		[ $deleted_lines_before_current_line -gt 0 ] || { printf "reg a '%s'\n" "0"; exit; }
    		printf "reg a '%s'\n" "$(expr $kak_opt_current_line - $deleted_lines_before_current_line)"
        }

        execute-keys '%s<esc><a-s>s^[\s/]+(console\.log|fmt\.Print|println|System\.out\.println|echo)<ret><a-x>d<ret><space>'
        
        set-option buffer current_line %reg{a}
        
        execute-keys %opt{current_line}
        execute-keys 'g<ret>'
    }
}

require-module prints-mode

map global prints c ': prints-mode-comment-prints<ret>' -docstring 'toggle comment all print statements'
map global prints d ': prints-mode-delete-prints<ret>' -docstring 'delete print statements'

