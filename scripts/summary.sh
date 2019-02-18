#! /bin/bash

function main {
    local filepath="$1"
    
    for PKG in $(cat "$filepath"); do
        local FILEPATH="source_code/$PKG/exception_info.txt"
        
        if [[ -f "$FILEPATH" ]]; then
            local total_exception_count=$(egrep --count --word-regex 'Expection Type::' "$FILEPATH")
            local reraise_count=$(egrep --count --word-regex 'Reraise::' "$FILEPATH")
            local base_exception_count=$(egrep --count --word-regex '(Exception|BaseException)' "$FILEPATH")

            #printf "PACKAGE: %-30s TOTAL_EXCEPTION_COUNT: %-5s RERAISE_COUNT: %-5s BASE_EXCEPTION_COUNT: %-5s\n" $PKG $total_exception_count $reraise_count $base_exception_count

            if [[ $total_exception_count -gt 0 ]]; then
                printf "| %s | %s | %s (%d%%) | %s (%d%%)\n" $PKG $total_exception_count $reraise_count $(( reraise_count * 100 / total_exception_count )) $base_exception_count $(( base_exception_count * 100 / total_exception_count ))
            else
                printf "| %s | %s | %s (%d%%) | %s (%d%%)\n" $PKG $total_exception_count $reraise_count 0 $base_exception_count 0
            fi

        fi
    done
    
}

main $@
