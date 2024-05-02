#!/bin/bash

input_dir=$1
output_dir=$2
copy_files() {
    local src_path=$1
    local dest_path=$2
    local name

    for file in "$src_path"/*; do
        if [[ -d "$file" ]]; then
            copy_files "$file" "$dest_path"
        elif [[ -f "$file" ]]; then
            name=$(basename -- "$file")
            if [[ -e "$dest_path/$name" ]]; then
                local cnt=1
                local new_name
                while [[ -e "$dest_path/${cnt}_$name" ]]; do
                    ((cnt++))
                done
                new_name="${cnt}_$name"
                cp -p "$file" "$dest_path/$new_name"
            else
                cp -p "$file" "$dest_path"
            fi
        fi
    done
}

copy_files "$input_dir" "$output_dir"
