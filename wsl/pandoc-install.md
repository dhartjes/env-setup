# Pandoc and Tectonic Installation (WSL/Ubuntu)

<-- [Back to README](../README.md)

Pandoc and Tectonic on the WSL side, for repos opened through VS Code's Remote - WSL. In that mode, the vscode-pandoc extension calls the `pandoc` in WSL, not the [Windows install](../windows/pandoc-install.md). Tectonic is a self-contained LaTeX engine that downloads the packages a document needs on first use. It takes MiKTeX's place on this side.

Prerequisite: [mise](mise/mise-install.md).

## Install via mise

```bash
mise use --global pandoc@latest
mise use --global github:tectonic-typesetting/tectonic@latest
```

Tectonic isn't in mise's registry, so it installs from its GitHub releases. That repo also tags its internal crates, but mise picks out the `tectonic@x.y.z` releases correctly.

## Verify

```bash
pandoc --version
tectonic --version
```

Smoke-test a PDF conversion:

```bash
printf '# Hello\n\nSome *text*.\n' > /tmp/hello.md
pandoc /tmp/hello.md --pdf-engine=tectonic -o /tmp/hello.pdf
```

The first run takes a minute while Tectonic downloads its TeX bundle into `~/.cache/Tectonic`.

## Point vscode-pandoc at Tectonic

Pandoc defaults to `pdflatex`, which isn't installed here. In VS Code connected to WSL, run **Preferences: Open Remote Settings (WSL: Ubuntu)** and add:

```json
"pandoc.pdfOptString": "--pdf-engine=tectonic"
```

Remote settings only apply inside WSL, so Windows-side PDF rendering keeps using MiKTeX's `pdflatex`.

## Source

- [Pandoc — Installing](https://pandoc.org/installing.html)
- [Tectonic — Installing](https://tectonic-typesetting.github.io/book/latest/installation/)
- [mise — GitHub backend](https://mise.jdx.dev/dev-tools/backends/github.html)

<-- Prev: [Pandoc and MiKTeX (Windows)](../windows/pandoc-install.md)
--> Next: [VS Code Extensions](../windows/vscode/vscode-extensions.md)
