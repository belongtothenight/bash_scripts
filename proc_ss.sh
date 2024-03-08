#!/bin/bash

# PIPELINE
# 1. Check path validity
# 2. Count total files
# 3. Move pictures from source to destination
# 4. Rename them automatically remove spaces in filename

#SRC="/home/$(whoami)/Pictures"
SRC="/run/media/11278041/44AB-5704/ICL/w3/hw3-1"
DST="/run/media/11278041/44AB-5704/ICL/w3/hw3-1"
RPC="_"
TYP="png"

# Check $SRC
if [ -d "$SRC" ]; then
    :
else
    echo ">> SRC path doesn't exist"
    exit
fi

# Check $DST
if [ -d "$DST" ]; then
    :
else
    echo ">> DST path doesn't exist"
    exit
fi

cd $SRC
fcnt=0

# Count files
for f in *.$TYP; do
    ((fcnt++))
done

echo ">> Processing files:"
fcnt_t=0
for f in *.$TYP; do
    ((fcnt_t++))
    fsrc="$SRC/$f"
    fdst="$DST/${fcnt_t}_${f// /$RPC}" # Replace space with specified character
    echo "($fcnt_t/$fcnt) $fsrc -> $fdst"
    mv "$fsrc" "$fdst"
done

echo ">> Process finished!"
