#!/bin/bash

FILE="output.txt"
TEMP_FILE="tempfile.txt"
LINES=$(wc -l < "$FILE")

# Randomly choose to add, modify, or delete
ACTION=$((RANDOM % 3))

random_line() {
  SEARCH_DIR="/etc" # Change this to the directory you want to search
  OUTPUT_FILE="output.txt"
  
  # Find a random file from the specified directory
  RANDOM_FILE=$(find "$SEARCH_DIR" -type f 2>/dev/null | shuf -n 1)
  
  # Get a random line from that file
  RANDOM_LINE=$(shuf -n 1 "$RANDOM_FILE" 2>/dev/null)

  echo "$RANDOM_LINE"
}

change() {
  FILE="output.txt"
  TEMP_FILE="tempfile.txt"
  LINES=$(wc -l < "$FILE")
  
  # Randomly choose to add, modify, or delete
  ACTION=$((RANDOM % 3))
  
  case $ACTION in
    0) # Add a random line from a random file
      echo "$(random_line)" >> "$FILE"
      ;;
    1) # Modify a random line with a random line from a random file
      if [ $LINES -gt 0 ]; then
        LINE_TO_MODIFY=$((RANDOM % LINES + 1))
        RANDOM_LINE_FROM_FILE=$(random_line)
        awk -v line="$LINE_TO_MODIFY" -v replacement="$RANDOM_LINE_FROM_FILE" 'NR==line{$0=replacement}1' "$FILE" > "$TEMP_FILE"
        mv "$TEMP_FILE" "$FILE"
      fi
      ;;
    2) # Delete a random line
      if [ $LINES -gt 0 ]; then
        LINE_TO_DELETE=$((RANDOM % LINES + 1))
        sed -i "${LINE_TO_DELETE}d" "$FILE"
      fi
      ;;
  esac
}

NUM_CHANGES=35
for ((i=0; i<$NUM_CHANGES; i++)); do
    change
done
