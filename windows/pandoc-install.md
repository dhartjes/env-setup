# Pandoc and MiKTeX Installation (Windows)

<-- [Back to README](../README.md)

Pandoc converts Markdown to other document formats (HTML, DOCX, PDF), and MiKTeX supplies the LaTeX engine (`pdflatex`) Pandoc uses for PDF output. Both are prerequisites for the [vscode-pandoc](vscode/vscode-extensions.md#vscode-pandoc) extension.

## Install via WinGet

```powershell
winget install --source winget --exact --id JohnMacFarlane.Pandoc
winget install --source winget --id MiKTeX.MiKTeX
```

Close and reopen the terminal so the updated `PATH` is picked up.

## Configure MiKTeX

MiKTeX ships a minimal package set and fetches LaTeX packages as documents need them. Allow it to do so without prompting, so Pandoc's PDF conversion doesn't stall on a hidden dialog:

```powershell
initexmf --set-config-value "[MPM]AutoInstall=1"
```

Then open **MiKTeX Console** from the Start menu and run **Check for updates** → **Update now** once.

## Verify

```powershell
pandoc --version
pdflatex --version
```

Smoke-test a PDF conversion:

```powershell
"# Hello" | Out-File -Encoding utf8 "$env:TEMP\hello.md"
pandoc "$env:TEMP\hello.md" -o "$env:TEMP\hello.pdf"
```

The first run may take a minute while MiKTeX downloads missing packages.

## Source

- [Pandoc — Installing](https://pandoc.org/installing.html)
- [MiKTeX — Getting started](https://miktex.org/howto/install-miktex)

<-- Prev: [VS Code Install](vscode/vscode-install.md)
--> Next: [Pandoc and Tectonic (WSL)](../wsl/pandoc-install.md)
