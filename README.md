# TruthByte

**TruthByte** is a powerful command-line tool for verifying file integrity by comparing computed hashes against expected values. It supports multiple hash algorithms and can process both individual files and entire directories, making it ideal for verifying downloads, backups, or any scenario requiring file integrity validation.

![Version](https://img.shields.io/badge/version-2.0-blue)

## Features

- **Multiple Hash Algorithms**: Support for SHA256, SHA512, SHA1, and MD5
- **Single File Verification**: Compare a file's hash against an expected value
- **Directory Verification**:
  - Process entire directories of files against a hash file
  - Recursive mode for checking subdirectories
- **Flexible Hash File Format**: Supports standard formats from common hash tools
- **Path Flexibility**: Works with both absolute and relative paths
- **Output Options**: Save verification results to text files
- **Friendly Interface**: Color-coded output for clear status indication
- **Convenient Access**: Available as both `truthbyte` and `tb` (alias)

## Installation

### Prerequisites

- Linux-based system
- Bash 4.0 or higher
- Standard Unix utilities (find, awk, etc.)

### Installation Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/username/truthbyte.git
   cd truthbyte
   ```

2. Run the installation script with root privileges:

   ```bash
   chmod +x install.sh
   sudo ./install.sh
   ```

   This will:

   - Install the `truthbyte` command to bin
   - Create a `tb` alias for easier access
   - Install the manual page
   - Set appropriate permissions

#### Installation from .deb Package

If you prefer to install from a pre-built package:

1. Download the latest .deb package from the [Releases](https://github.com/Opu-H/truthbyte/releases) page

2. Install using dpkg:

   ```bash
   sudo dpkg -i truthbyte_2.0-1.deb
   ```

3. Verify installation:
   ```bash
   truthbyte --version
   ```

## Usage

### Single File Verification

Verify a single file by providing its hash:

```bash
truthbyte -a sha256 /path/to/file.iso 61d034473102d1bee8c67fe7f917da99400f342c167d1b470e385e4c10339b27
```

### Directory Verification

Verify all files in a directory against a hash file:

```bash
truthbyte -a md5 -v hashes.md5 ~/Downloads/
```

### Recursive Directory Verification

Verify files in a directory and all its subdirectories:

```bash
truthbyte -a sha256 -r --verify-from signatures.sha256 ~/Projects/
```

### Logging Results to a File

Save verification results to a text file:

```bash
truthbyte -a sha256 -r -v hashes.sha256 ~/Documents/ -o verification_results.txt
```

### Command Line Options

| Option           | Long Form              | Description                                |
| ---------------- | ---------------------- | ------------------------------------------ |
| `-a <algorithm>` |                        | Hash algorithm (sha256, sha512, sha1, md5) |
| `-r`             | `--recursive`          | Recursively process directories            |
| `-v <file>`      | `--verify-from <file>` | Read expected hashes from file             |
| `-o <file>`      | `--output <file>`      | Save results to a .txt file                |
| `-h`             | `--help`               | Show help message                          |
|                  | `--version`            | Display version information                |

### Hash File Format

TruthByte supports standard hash file formats:

```
<hash> <filename>
```

Example (SHA256):

```
61d034473102d1bee8c67fe7f917da99400f342c167d1b470e385e4c10339b27 file.iso
8d8d1d4aad5f7448f037f386387a75b077f8abcb09abdff5d70f405d91cb429f document.pdf
```

## Exit Codes

| Code | Meaning                              |
| ---- | ------------------------------------ |
| 0    | Success - All hashes matched         |
| 1    | Error - Hash mismatch or other error |
| 2    | Warning - No files were checked      |

## Documentation

View the full manual with:

```bash
man truthbyte
```

## Examples

### Verify an ISO image

```bash
truthbyte -a sha256 ubuntu-22.04.3-desktop-amd64.iso 45f67b18afe97c47eec1af0b8051a8f1045c30107cd64e40a9ed2fcf3450b736
```

### Check all files in a download directory

```bash
truthbyte -a sha256 -v checksums.txt -r ~/Downloads/
```

### Create and use a verification log

```bash
truthbyte -a md5 -v package-hashes.md5 ~/software/ -o verification_log.txt
```

## Contributing

Contributions are welcome! Feel free to submit issues or pull requests to improve TruthByte.

## License

This project is open source and available under [LICENSE].

## Acknowledgements

TruthByte uses standard Unix utilities like `sha256sum`, `md5sum`, etc. for hash calculation.
