#! /bin/bash

function main {
    local filepath="$1"
    local count=1
    
    for PKG in $(cat "$filepath"); do

        (
            cd "source_code/$PKG"

            local FILEPATH="exception_info.txt"
            
            if [[ -f "$FILEPATH" ]]; then
                local loc=$(cloc . | egrep '^Python' | awk '{ print $5 }')
                local total_exception_count=$(egrep --count --word-regex 'Expection Type::' "$FILEPATH")
                local reraise_count=$(egrep --count --word-regex 'Reraise::' "$FILEPATH")
                local base_exception_count=$(egrep --count --word-regex '(Exception|BaseException)' "$FILEPATH")

                if [[ $total_exception_count -gt 0 ]]; then
                    printf "| %d | %s | %s | %s | %s (%d%%) | %s (%d%%)\n" $count $PKG $loc $total_exception_count $reraise_count $(( reraise_count * 100 / total_exception_count )) $base_exception_count $(( base_exception_count * 100 / total_exception_count ))
                else
                    printf "| %d | %s | %s | %s | %s (%d%%) | %s (%d%%)\n" $count $PKG $loc $total_exception_count $reraise_count 0 $base_exception_count 0
                fi
            fi
        )
        count=$(( count + 1 ))
    done
    
}

main $@
