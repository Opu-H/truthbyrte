#!/bin/bash

# === TruthByte: A CLI tool to verify file hashes ===
VERSION="1.0.0"

# === Color Vars ===
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# === Expand tilde (~) to home ===
expand_path() {
    local input="$1"
    [[ "$input" =~ ^~ ]] && echo "${input/#\~/$HOME}" || echo "$input"
}

# === Check if a command exists, or install it ===
check_command() {
    command -v "$1" &>/dev/null || {
        echo -e "${RED}Missing dependency: $1${NC}"
        exit 1
    }
}

# === Show help ===
show_help() {
    cat <<EOF
🛡️  TruthByte $VERSION - Verify file integrity using hash algorithms

Usage:
  truthbyte -P <full_path_to_file> -a <algorithm> -h <expected_hash>
  truthbyte -N <filename_in_current_dir> -a <algorithm> -h <expected_hash>

Options:
  -P <path>         : Full path to file
  -N <name>         : File in current directory
  -a <algorithm>    : Hash algorithm (sha256, sha512, sha1, md5)
  -h <hash>         : Expected hash to match
  --help            : Show this help message
  --version         : Show version
  --upgrade         : Upgrade TruthByte CLI (requires Git repo)

Examples:
  truthbyte -P ~/file.iso -a sha256 -h abc123...
  truthbyte -N file.zip -a md5 -h 9a0364b9e99bb480dd25e1f0284c8555
EOF
    exit 0
}

# === Show version ===
show_version() {
    echo "TruthByte version $VERSION"
    exit 0
}

# === Upgrade mechanism ===
upgrade_tool() {
    echo "📡 Downloading latest version..."
    sudo curl -s -L https://github.com/Opu-H/truthbyrte/releases/download/v1.0.0/truthbyte.sh -o /usr/local/bin/truthbyte
    sudo chmod +x /usr/local/bin/truthbyte
    echo "✅ Upgrade complete!"
    exit 0
}

# === Handle --help, --version, --upgrade ===
for arg in "$@"; do
    case $arg in
        --help) show_help ;;
        --version) show_version ;;
        --upgrade) upgrade_tool ;;
    esac
done

# === Parse CLI arguments ===
while getopts ":P:N:a:h:" opt; do
  case ${opt} in
    P ) FILE_PATH=$(expand_path "$OPTARG") ;;
    N ) FILE_PATH=$(pwd)/"$OPTARG" ;;
    a ) HASH_TYPE=$OPTARG ;;
    h ) EXPECTED_HASH=$(echo "$OPTARG" | tr -d '[:space:]') ;;
    \? ) echo -e "${RED}Invalid option: -$OPTARG${NC}" >&2; exit 1 ;;
    : ) echo -e "${RED}Option -$OPTARG requires an argument.${NC}" >&2; exit 1 ;;
  esac
done

# === Validate input ===
[ -z "$FILE_PATH" ] && echo -e "${RED}Error: No file path provided${NC}" && exit 1
[ -z "$HASH_TYPE" ] && echo -e "${RED}Error: No hash algorithm provided${NC}" && exit 1
[ -z "$EXPECTED_HASH" ] && echo -e "${RED}Error: No expected hash provided${NC}" && exit 1
[ ! -f "$FILE_PATH" ] && echo -e "${RED}Error: File does not exist at $FILE_PATH${NC}" && exit 1

# === Supported algorithms ===
case $HASH_TYPE in
    sha256) SUM_CMD="sha256sum" ;;
    sha1)   SUM_CMD="sha1sum" ;;
    sha512) SUM_CMD="sha512sum" ;;
    md5)    SUM_CMD="md5sum" ;;
    *) echo -e "${RED}Unsupported hash algorithm: $HASH_TYPE${NC}"; exit 1 ;;
esac

check_command "$SUM_CMD"

# === Compare Hash ===
ACTUAL_HASH=$($SUM_CMD "$FILE_PATH" | awk '{print $1}')
if [[ "$ACTUAL_HASH" == "$EXPECTED_HASH" ]]; then
    echo -e "${GREEN}✅ Success: Hash matched!${NC}"
else
    echo -e "${RED}❌ Mismatch: Hashes do not match!${NC}"
    echo "Expected: $EXPECTED_HASH"
    echo "Actual  : $ACTUAL_HASH"
fi
