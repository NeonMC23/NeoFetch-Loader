# Fastfetch Random Logo Selector

A Bash script that automatically changes the ASCII logo and associated colors in **Fastfetch** every time a **Konsole** terminal is opened.

The script randomly selects a logo from a JSON list, applies its associated color scheme, and launches Fastfetch automatically through `.bashrc`.

---

## Features

* 🎲 Random Fastfetch logo selection
* 🎨 Custom color palette per logo
* 🖼️ Support for custom ASCII logos
* 🚀 Automatic execution when opening Konsole
* 🐧 Compatible with Nobara 44 / Fedora and other Bash-based Linux distributions
* ⚡ No permanent modification of `config.jsonc`
* 🔒 Prevents accidental Fastfetch configuration corruption

---

# Directory Structure

The expected file structure is:

```text
~/.config/fastfetch/
│
├── config.jsonc
│
├── random-fastfetch.sh
│
└── logos/
    │
    ├── list.json
    ├── logo1.txt
    ├── logo2.txt
    ├── logo3.txt
    └── ...
```

---

# Installation

## 1. Install dependencies

The script uses `jq` to read JSON files.

On Nobara/Fedora:

```bash
sudo dnf install jq
```

---

## 2. Create directories

```bash
mkdir -p ~/.config/fastfetch/logos
```

---

## 3. Add your ASCII logos

Place your custom ASCII files inside:

```text
~/.config/fastfetch/logos/
```

Example:

```text
logo1.txt
logo2.txt
logo3.txt
```

Each file should contain only the ASCII art.

---

# Logo Configuration

Create the file:

```text
~/.config/fastfetch/logos/list.json
```

Example:

```json
{
  "logos": [
    {
      "path": "/home/neon/.config/fastfetch/logos/logo1.txt",
      "colors": {
        "1": "blue",
        "2": "cyan"
      }
    },
    {
      "path": "/home/neon/.config/fastfetch/logos/logo2.txt",
      "colors": {
        "1": "red",
        "2": "yellow"
      }
    },
    {
      "path": "/home/neon/.config/fastfetch/logos/logo3.txt",
      "colors": {
        "1": "green",
        "2": "white"
      }
    }
  ]
}
```

---

## Configuration Format

### `path`

Defines the location of the ASCII logo:

```json
"path": "/home/neon/.config/fastfetch/logos/logo1.txt"
```

---

### `colors`

Defines the Fastfetch logo color mapping:

```json
"colors": {
    "1": "blue",
    "2": "cyan"
}
```

The numbers correspond to Fastfetch color markers inside the ASCII file.

Example:

```text
$1████████
$2██ NOBARA ██
```

Result:

* `$1` → blue
* `$2` → cyan

---

# Script Installation

Create the script:

```bash
nano ~/.config/fastfetch/random-fastfetch.sh
```

Add:

```bash
#!/bin/bash

FASTFETCH_DIR="$HOME/.config/fastfetch"
LIST="$FASTFETCH_DIR/logos/list.json"

COUNT=$(jq '.logos | length' "$LIST")

INDEX=$((RANDOM % COUNT))

LOGO=$(jq -r ".logos[$INDEX].path" "$LIST")

COLOR1=$(jq -r ".logos[$INDEX].colors[\"1\"]" "$LIST")
COLOR2=$(jq -r ".logos[$INDEX].colors[\"2\"] // empty" "$LIST")

fastfetch \
--logo-type file \
--logo "$LOGO" \
--logo-color-1 "$COLOR1" \
${COLOR2:+--logo-color-2 "$COLOR2"}
```

---

## Make the script executable

```bash
chmod +x ~/.config/fastfetch/random-fastfetch.sh
```

Test it manually:

```bash
~/.config/fastfetch/random-fastfetch.sh
```

---

# Automatic Launch with Konsole

Edit your Bash configuration:

```bash
nano ~/.bashrc
```

Add at the end:

```bash
# Random Fastfetch logo on Konsole startup

if [[ $- == *i* ]]; then
    ~/.config/fastfetch/random-fastfetch.sh
fi
```

From now on, every time Konsole starts:

1. Bash loads `.bashrc`
2. The script runs
3. A random logo is selected
4. The associated colors are applied
5. Fastfetch displays the result

---

# Troubleshooting

## Permission denied

Error:

```text
Permission denied
```

Fix:

```bash
chmod +x ~/.config/fastfetch/random-fastfetch.sh
```

---

## Invalid JSON error

Check your JSON file:

```bash
jq . ~/.config/fastfetch/logos/list.json
```

If the file contains syntax errors, `jq` will display the problematic line.

---

## Fastfetch does not display the logo

Test manually:

```bash
fastfetch \
--logo-type file \
--logo ~/.config/fastfetch/logos/logo1.txt
```

---

# Customization Ideas

This system can easily be extended:

* Add new logos by dropping additional `.txt` files
* Create custom color themes
* Add distribution-specific logos
* Change themes depending on time of day
* Select logos depending on GPU or KDE Plasma theme

---

# License

Personal Linux customization project.

Free to use and modify.
