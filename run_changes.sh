#!/bin/bash

random_number=$(( ( RANDOM % 5 )  + 1 ))

for ((i=0; i<$random_number; i++)); do
    ./change.sh
    git add .
    git commit -m "Change $i $(date)"
done

git push origin main
