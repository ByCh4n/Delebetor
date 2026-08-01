<h1 align="center">Delebetor</h1>

<p align="center">
  <img src="https://github.com/ByCh4n/Delebetor/actions/workflows/shellcheck.yml/badge.svg" alt="ShellCheck" />
  <img src="https://img.shields.io/github/license/ByCh4n/Delebetor" alt="License" />
  <img src="https://img.shields.io/github/stars/ByCh4n/Delebetor?style=social" alt="Stars" />
</p>

Delebetor installs and configures the tools commonly used during penetration
testing, and can also remove them again when you are done. It groups tools by
install method — `apt` packages and `git`-based projects under `/opt` — and
reports the result of every single tool so you always know what succeeded and
what failed.

## Features

- Installs a curated set of pentest tools via `apt` and `git`
- **Per-tool status reporting** — no more silent failures
- Separate `web` tool set for web-focused assessments
- Guarded `delete` action (root + confirmation) to clean up `/opt` and history
- Usable interactively (menu) or non-interactively (command arguments)

## Requirements

- `bash`
- An `apt`-based distribution (Kali Linux / Debian / Ubuntu)
- `git`
- Root privileges (`sudo`)

## Installation

```bash
git clone https://github.com/ByCh4n/Delebetor.git
cd Delebetor
sudo make install
```

This installs the `delebetor` command to `/usr/bin`. You can also run it
directly with `sudo bash Delebetor.sh`.

## Usage

Launch the interactive shell:

```bash
sudo delebetor
```

Or run a command directly:

```bash
sudo delebetor install
```

| Command | Description |
|---------|-------------|
| `install` | Install the full apt + git pentest tool set |
| `web` | Install the web-focused tool set (nuclei, subfinder, httprobe, dnsrecon) |
| `delete` | Remove `/opt` tools and shell history (asks for confirmation) |
| `banner` | Print the ASCII banner |
| `version` / `-v` | Show the version |
| `help` / `-h` | Show the command list |
| `exit` | Quit the interactive shell |

## Disclaimer

This project is provided for **authorized security testing and educational
purposes only**. The `delete` action permanently removes files under `/opt` and
your shell history — use it with care. The author accepts no liability for
misuse or data loss.

## Author

**Hüseyin Altıntaş — ByCh4n**

- GitHub: [@ByCh4n](https://github.com/ByCh4n)
- LinkedIn: [huseyinaltns](https://www.linkedin.com/in/huseyinaltns/)
- X: [@huseyinaltns](https://x.com/huseyinaltns)

Special thanks to [@lazypwny751](https://github.com/lazypwny751).

## License

Licensed under the [GPL-3.0](LICENSE) license.
