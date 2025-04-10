#!/bin/bash

# === TruthByte: A CLI tool to verify file hashes ===
# Usage:
#   truthbyte -P <full_path_to_file> -a <algorithm> -h <expected_hash>
#   truthbyte -N <filename_in_current_dir> -a <algorithm> -h <expected_hash>

# === Variables ===
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# === Expand tilde (~) to home ===
expand_path() {
    local input="$1"
    if [[ "$input" =~ ^~ ]]; then
        echo "${input/#\~/$HOME}"
    else
        echo "$input"
    fi
}

# === Check if a command exists, or install it ===
check_command() {
    command -v "$1" &>/dev/null || {
        echo -e "${RED}Missing dependency: $1${NC}"
        exit 1
    }
}

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

# === Check supported algorithms ===
case $HASH_TYPE in
    sha256) SUM_CMD="sha256sum" ;;
    sha1)   SUM_CMD="sha1sum" ;;
    sha512) SUM_CMD="sha512sum" ;;
    md5)    SUM_CMD="md5sum" ;;
    *) echo -e "${RED}Unsupported hash algorithm: $HASH_TYPE${NC}"; exit 1 ;;
esac

check_command "$SUM_CMD"

# === Calculate and Compare ===
ACTUAL_HASH=$($SUM_CMD "$FILE_PATH" | awk '{print $1}')

if [[ "$ACTUAL_HASH" == "$EXPECTED_HASH" ]]; then
    echo -e "${GREEN}Success: Hash matched!${NC}"
else
    echo -e "${RED}Mismatch: Hashes do not match!${NC}"
    echo "Expected: $EXPECTED_HASH"
    echo "Actual  : $ACTUAL_HASH"
fi
