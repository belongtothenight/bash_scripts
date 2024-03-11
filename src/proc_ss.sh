#!/bin/bash

# PIPELINE
# 1. Move pictures from source to destination
# 2. Rename them automatically remove spaces in filename

# VARIABLES

# -- source path, do not include the last slash at the end
#SRC="/home/$(whoami)/Pictures"
SRC="/home/$(whoami)"
# -- destination path, do not include the last slash at the end
#DST="/run/media/11278041/44AB-5704/ICL/w3/hw3-1"
DST="/home/$(whoami)"
# -- filtering filetype, the "dot" is required
TYP=".png"
# -- Keep Original Name
KON=false
# -- Replace original space with this character, only active if $KON is true
RPC="_"

# Check $SRC
if [ -d "$SRC" ]; then
    :
else
    echo ">> \$SRC path doesn't exist"
    exit
fi

# Check $DST
if [ -d "$DST" ]; then
    :
else
    echo ">> \$DST path doesn't exist"
    exit
fi

# Check $TYP
if [[ $TYP == .* ]]; then
    :
else
    echo ">> \$TYP format isn't correct, should start with a \"dot\""
    exit
fi

# Check $KON
if [ $KON = true ] || [ $KON = false ]; then
    :
else
    echo ">> \$KON format isn't correct, should be either \"true\" or \"false\""
    exit
fi

cd $SRC
fcnt=0

# Count files
for f in *$TYP; do
    ((fcnt++))
done

# Display following changes and ask for permission
echo ">> Following changes:"
fcnt_t=0
for f in *$TYP; do
    ((fcnt_t++))
    fsrc="$SRC/$f"
    if [ "$KON" = true ]; then
        fdst="$DST/${fcnt_t}_${f// /$RPC}" # Replace space with specified character
    else
        fdst="$DST/${fcnt_t}$TYP"
    fi
    echo "($fcnt_t/$fcnt) $fsrc -> $fdst"
done
read -p ">> Are you sure to continue? [Yy] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    :
else
    echo ">> Process terminated!"
    exit
fi

# Process files
echo ">> Processing files:"
fcnt_t=0
for f in *$TYP; do
    ((fcnt_t++))
    fsrc="$SRC/$f"
    if [ "$KON" = true ]; then
        fdst="$DST/${fcnt_t}_${f// /$RPC}" # Replace space with specified character
    else
        fdst="$DST/${fcnt_t}$TYP"
    fi
    echo "($fcnt_t/$fcnt) $fsrc -> $fdst"
    mv "$fsrc" "$fdst"
done

echo ">> Process finished!"
