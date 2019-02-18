#! /bin/bash

SCRIPTS_DIR=$(dirname $0)

function main {
    local filepath="$1"
    
    for PKG in $(cat "$filepath"); do
        if [[ -d $PKG ]]; then
            (echo "************** $PKG *************";
             cd $PKG;
             python3 "$SCRIPTS_DIR/parse_exceptions.py" $(find . -name '*.py') > exception_info.txt 
            )
        fi
    done
}

main $@

