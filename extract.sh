#!/bin/bash

# Extract principal IDs from holders.txt and export to Downloads
# Usage: ./extract.sh

INPUT_FILE="holders.txt"
OUTPUT_FILE="$HOME/Downloads/principals.txt"

if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found"
    exit 1
fi

# Extract the hex strings after "record {N;" pattern and format with quotes
grep -o 'record {[0-9]*; "[a-f0-9]*"' "$INPUT_FILE" | sed 's/record {[0-9]*; "//;s/"//' | sort -u | awk '{print "  \"" $0 "\""}' > "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "✓ Principal IDs extracted successfully!"
    echo "✓ Output saved to: $OUTPUT_FILE"
    echo ""
    echo "Preview (first 5):"
    head -5 "$OUTPUT_FILE"
    echo "..."
else
    echo "✗ Extraction failed"
    exit 1
fi