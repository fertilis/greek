#!/bin/bash

PROJECT_DIR=$(cd "$(dirname $(readlink -f "${BASH_SOURCE[0]}"))" && pwd)

md_path_prefix=$PROJECT_DIR/md

for md_path in $(find $md_path_prefix -name "*.md")
do
    md_path_suffix=${md_path#$md_path_prefix}
    html_path=$PROJECT_DIR/html${md_path_suffix%.md}.html
    echo "$md_path -> $html_path"
    pandoc -s -f markdown -t html5 --shift-heading-level-by=1 -o $html_path $md_path
done
