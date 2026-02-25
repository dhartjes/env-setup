# Python VS Code Setup

## Installation

To get your python tools working in your vscode instance through wsl:

1. launch this project (or any project with python files) from the wsl terminal with `code .`
1. Open the a .py file like [does-vscode-have-linter-and-formatter.py](./does-vscode-have-linter-and-formatter.py)
1. If you don't yet have it, VSCode will recommend the Python Extension.
1. Once installed, right click within your open *.py file and select Format (or run format with Shift+Alt+F)
1. Choose a Python formatter. I'm going with black.

## Configuration

1. Launch the Command Palette (Ctrl+Shift+P) and run Preferences: Open User Settings (JSON)
1. Add the following:

```text
    "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter",
        "editor.formatOnSave": true
    }
```

1. For running the code formatter in Linux and ensuring that black is available both within VSCode and in the terminal, black can be installed with:

```bash
python3 -m pip install black

black <name-of-file.py>
```

1. More configuration examples can be seen at [Usage and Configuration](https://black.readthedocs.io/en/stable/usage_and_configuration/index.html)

## Sources

- [VSCode Python Formatter](https://coderivers.org/blog/vscode-python-formatter/)
- [Black - PyPI](https://pypi.org/project/black/)
