#!/bin/bash

read_random_lines() {
  SEARCH_DIR="/etc" # Change this to the directory you want to search
  OUTPUT_FILE="output.txt"
  
  # Find a random file from the specified directory
  RANDOM_FILE=$(find "$SEARCH_DIR" -type f 2>/dev/null | shuf -n 1)
  
  # Get a random line from that file
  RANDOM_LINE=$(shuf -n 1 "$RANDOM_FILE" 2>/dev/null)

  # Append the random line to the output file
  echo "$RANDOM_LINE" >> "$OUTPUT_FILE"
}


NUM_LINES=1000
for ((i=0; i<$NUM_LINES; i++)); do
    read_random_lines
done
