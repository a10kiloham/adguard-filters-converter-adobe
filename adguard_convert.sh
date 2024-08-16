#!/bin/bash

# Check if the input file is provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_hosts_file> <output_filter_file>"
    exit 1
fi

input_file="$1"
output_file="$2"

# Create or empty the output file
> "$output_file"

# Read the input hosts file and process each line
while IFS= read -r line; do
    # Ignore comments and blank lines
    if [[ "$line" =~ ^# ]] || [[ -z "$line" ]]; then
        continue
    fi

    # Extract the domain name (second part of the line)
    domain=$(echo "$line" | awk '{print $2}')

    # Append the formatted domain to the output file
    echo "||$domain^" >> "$output_file"
done < "$input_file"

echo "Conversion complete. Filter format saved to $output_file."
