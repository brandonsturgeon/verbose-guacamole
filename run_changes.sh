#!/bin/bash

random_number=$(( ( RANDOM % 5 )  + 1 ))
random_text() {
    head -c 500 /dev/urandom | tr -dc 'a-zA-Z0-9~!@#$%^&*_-' | fold -w 75 | head -n 1
}

for ((i=0; i<$random_number; i++)); do
    ./change.sh
    git add .
    git commit -m "Change $i $(date) - $(random_text)"
done

git push origin main
