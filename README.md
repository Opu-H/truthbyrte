# TruthByte

**TruthByte** is a simple and efficient command-line tool for verifying file integrity by comparing hashes. It supports multiple hash algorithms (SHA256, SHA1, MD5, and SHA512) and provides easy-to-understand feedback on whether the file's hash matches the expected value.

---

## Features

- Supports multiple hash algorithms (SHA256, SHA1, MD5, SHA512)
- Flexible input options: full file path or file in the current directory
- Easy-to-use with command-line flags
- `truthbyte` and `tb` can be used as commands
- Installable via an `install.sh` script

---

## Installation

### Prerequisites
- Linux-based system
- Bash shell

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/Opu-H/truthbyrte.git
   cd truthbyte
   ```

2. Run the installation script:
   ```bash
    sudo chmod +x install.sh
   ./install.sh
   ```

   This will:
   - Install the `truthbyte` tool into `/usr/local/bin/`
   - Create an alias `tb` for easier access
   - Install the manual page
   - Ensure everything is set up for global use

---

## Usage

### Command Syntax

```bash
truthbyte -P <full_path_to_file> -a <algorithm> -h <expected_hash>
truthbyte -N <filename_in_current_dir> -a <algorithm> -h <expected_hash>
```

- `-P <full_path_to_file>`: Provide the full path to the file (e.g., `/home/user/file.iso`)
- `-N <filename_in_current_dir>`: Provide the filename if you're in the directory containing the file
- `-a <algorithm>`: Specify the hash algorithm: `sha256`, `sha1`, `sha512`, `md5`
- `-h <expected_hash>`: Provide the expected hash value to compare

### Examples

1. **Using a file with the full path:**

   ```bash
   truthbyte -P ~/Downloads/file.iso -a sha256 -h d2d2d2d2...
   ```

2. **Using a file in the current directory:**

   ```bash
   truthbyte -N file.iso -a md5 -h abcdef123456...
   ```

3. **With the `tb` alias:**

   ```bash
   tb -N file.iso -a sha512 -h 1234567890abcdef...
   ```

---

## Man Page

You can view the manual page for detailed usage instructions by running:

```bash
man truthbyte
```

---

## Contributing

Feel free to fork the repository and submit pull requests for any improvements or fixes.
