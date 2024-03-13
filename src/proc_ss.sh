#!/bin/bash

# PIPELINE
# 1. Move pictures from source (no subdirectory) to destination
# 2. Rename them automatically. (optional) leave original name at the end and remove spaces in filename

# VARIABLES DEFAULT VALUE

# -- source path, do not include the last slash at the end (-s)
#SRC="/home/$(whoami)"
SRC="/home/$(whoami)/Pictures"
# -- destination path, do not include the last slash at the end (-d)
#DST="/home/$(whoami)"
DST="/run/media/11278041/44AB-5704/ICL/w3/hw3-1"
# -- filtering filetype, the "dot" at the start is required (-t)
TYP=".png"
# -- Keep Original Name, "true" or "false" (-k)
KON=false
# -- Replace original space with this character, only active if $KON is true (-r)
RPC="_"

# Help Message
help () {
    echo "================================================================================================================================"
    echo "Usage: proc_ss.sh -s=<source_path> -d=<destination_path> -t=<filetype> -k=<keep_original_name_bool> -r=<replace_space_character>"
    echo -e "Options:"
    echo -e "  -s, --source=<source_path>\t\tSource path, do not include the last slash at the end"
    echo -e "  -d, --destination=<destination_path>\tDestination path, do not include the last slash at the end"
    echo -e "  -t, --type=<filetype>\t\t\tFiltering filetype, the \"dot\" at the start is required"
    echo -e "  -k, --keep_original_name=<true/false>\tKeep Original Name, \"true\" or \"false\""
    echo -e "  -r, --replace_space=<replace_space_character>\tReplace original space with this character, only active if \"-k\" is true"
    echo -e "Example: proc_ss.sh -s=/home/$(whoami)/Pictures -d=/run/media/11278041/44AB-5704/ICL/w3/hw3-1 -t=.png -k=false -r=_"
    exit
}

# Exit Handler
#set -eE -o functrace
#failure () {
#    local line_no=$1
#    local bash_cmd=$2
#    local bash_fun=$3
#    local bash_src=$4
#    echo "Error: source: $BOLD$bash_src$END, $BOLD$bash_fun$END has failed at line $BOLD$line_no$END, command: $BOLD$bash_cmd$END"
#    help
#}
#trap '>> failure "$LINENO" "$BASH_COMMAND" "$FUNCNAME" "$BASH_SOURCE"' ERR

# CLI Argument Parsing
# -- template = "--option=value"
for i in "$@"; do
    case $i in
        -h|--help)
            help
            ;;
        -s=*|--source=*)
            SRC="${i#*=}"
            shift
            ;;
        -d=*|--destination=*)
            DST="${i#*=}"
            shift
            ;;
        -t=*|--type=*)
            TYP="${i#*=}"
            shift
            ;;
        -k=*|--keep_original_name=*)
            KON="${i#*=}"
            shift
            ;;
        -r=*|--replace_space=*)
            RPC="${i#*=}"
            shift
            ;;
        *)
            #echo ">> Unknown option: $i"
            #help
            ;;
    esac
done
# -- template = "--option value"
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -s|--source)
            SRC="$2"
            shift # past argument
            shift # past value
            ;;
        -d|--destination)
            DST="$2"
            shift # past argument
            shift # past value
            ;;
        -t|--type)
            TYP="$2"
            shift # past argument
            shift # past value
            ;;
        -k|--keep_original_name)
            KON="$2"
            shift # past argument
            shift # past value
            ;;
        -r|--replace_space)
            RPC="$2"
            shift # past argument
            shift # past value
            ;;
        -s=*|--source=*|-d=*|--destination=*|-t=*|--type=*|-k=*|--keep_original_name=*|-r=*|--replace_space=*)
            # Previously parsed format
            shift
            ;;
        -*|--*)
            echo ">> Unknown option: $1"
            shift
            help
            ;;
        *)
            POSITIONAL_ARGS+=("$1")
            shift # past argument
            ;;
    esac
done
echo ">> CLI arguments:"
echo -e "Source path: \t\t$SRC"
echo -e "Destination path: \t$DST"
echo -e "Filtering filetype: \t$TYP"
echo -e "Keep Original Name: \t$KON"
echo -e "Replace space with: \t$RPC"

# Check $SRC
if [ -d "$SRC" ]; then
    :
else
    echo ">> \$SRC path doesn't exist"
    help
fi

# Check $DST
if [ -d "$DST" ]; then
    :
else
    echo ">> \$DST path doesn't exist"
    help
fi

# Check $TYP
if [[ $TYP == .* ]]; then
    :
else
    echo ">> \$TYP format isn't correct, should start with a \"dot\""
    help
fi

# Check $KON
if [ $KON = true ] || [ $KON = false ]; then
    :
else
    echo ">> \$KON format isn't correct, should be either \"true\" or \"false\""
    help
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
    help
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
