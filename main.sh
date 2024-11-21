#!/bin/bash

while getopts ":l:L:s:c:d:" opt; do
  case $opt in
    l) argl="$OPTARG"
    ;;
    L) argL="$OPTARG"
    ;;
    s) args="$OPTARG"
    ;;
    c) argc="$OPTARG"
    ;;
    d) argd="$OPTARG"
    ;;
    \?) echo "Invalid option: -$OPTARG" >&2; echo ""; cat src/1_help.txt; echo ""; exit 1
    ;;
  esac
done

echo $argl
echo $argL
echo $arga
echo $args
echo $argc
echo $argd
