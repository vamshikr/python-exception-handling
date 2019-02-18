#! /bin/bash


function untar {

    local filepath="$1"
    
    if [[ -f "$filepath" ]]; then
        local fileext="${filepath/*./}"        

        case "$fileext" in
            whl)
                unzip -o -q "$filepath"
            ;;
            gz)
                tar xf "$filepath"
            ;;
            zip)
                unzip -o -q "$filepath"
            ;;
        esac
    fi
}

function main {

    local filepath="$1"
    
    for project in $(cat "$filepath"); do

        if [[ ! -d "$project" ]]; then
            mkdir "$project"
        fi

        (
            cd "$project" && \
                # pip download --no-deps --python-version 3 "$project" && \
                for FILENAME in $(find . -mindepth 1 -maxdepth 1 -type f -name '*.tar.gz' -o -name '*.whl' -o -name '*.zip'); do
                    untar "$FILENAME"
                done
        )
    done
}

set -x;

main $@
