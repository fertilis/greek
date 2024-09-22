import subprocess as sub
import shutil
import os


from pathlib import Path


def main():
    project_dir = os.path.dirname(os.path.abspath(__file__))
    md_dir = Path(f"{project_dir}/md")
    html_dir = Path(f"{project_dir}/docs")
    try:
        shutil.rmtree(html_dir)
    except FileNotFoundError:
        pass
    os.makedirs(html_dir, exist_ok=True)
    md_paths = recursively_list_directory(md_dir)
    html_paths = [
        replace_path_prefix(path, md_dir, html_dir).with_suffix(".html")
        for path in md_paths
    ]

    for md_path, html_path in zip(md_paths, html_paths):
        os.makedirs(html_path.parent, exist_ok=True)
        print(f"{md_path} -> {html_path}")
        args = [
            "pandoc",
            "-s",
            "-f",
            "markdown",
            "-t",
            "html5",
            "--css",
            "./style_copy.css",
            "-o",
            html_path,
            md_path,
        ]
        sub.run(args)


def recursively_list_directory(directory) -> list[Path]:
    output = []
    for root, _dirs, files in os.walk(directory):
        for file in files:
            output.append(Path(f"{root}/{file}"))
    output.sort()
    return output


def replace_path_prefix(path: Path, old_prefix: Path, new_prefix: Path) -> Path:
    path = path.resolve()
    old_prefix = old_prefix.resolve()
    if path.is_relative_to(old_prefix):
        return new_prefix / path.relative_to(old_prefix)
    else:
        return path


if __name__ == "__main__":
    main()
