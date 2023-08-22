#!/bin/bash

FILE="output.txt"
TEMP_FILE="tempfile.txt"
LINES=$(wc -l < "$FILE")

# Randomly choose to add, modify, or delete
ACTION=$((RANDOM % 3))

change() {
    case $ACTION in
    0) # Add a random line
      echo "Random addition" >> "$FILE"
      ;;
    1) # Modify a random line
      if [ $LINES -gt 0 ]; then
        LINE_TO_MODIFY=$((RANDOM % LINES + 1))
        awk -v line="$LINE_TO_MODIFY" 'NR==line{$0="Random modification"}1' "$FILE" > "$TEMP_FILE"
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
