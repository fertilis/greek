#!/bin/bash

project_dir=$(cd "$(dirname $(readlink -f "${BASH_SOURCE[0]}"))" && pwd)

md_path_prefix=$project_dir/md
html_path_prefix=$project_dir/docs
mkdir -p $html_path_prefix
cp $project_dir/style.css $html_path_prefix/_style.css

for md_path in $(find $md_path_prefix -name "*.md")
do
    md_path_suffix=${md_path#$md_path_prefix}
    html_path=$html_path_prefix${md_path_suffix%.md}.html
    echo "$md_path -> $html_path"
    pandoc -s -f markdown -t html5 --css ./_style.css -o $html_path $md_path
done
