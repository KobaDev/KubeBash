#!/bin/bash
while getopts ":c:l:Ls:dhni" opt; do
  case $opt in
    c) ./src/kubeconfig.sh "$OPTARG"
    ;;
    l) ./src/getlogs.sh "$OPTARG"
    ;;
    L) ./src/getlogslist.sh
    ;;
    s) ./src/getshell.sh "$OPTARG"
    ;;
    d) ./src/deleteevicted.sh
    ;;
    n) ./src/getnonrunningpods.sh
    ;;
    i) ./src/getallingresses.sh
    ;;
    h) cat src/_help.txt
    ;;
    \?) echo "Invalid option: -$OPTARG" >&2; echo ""; cat src/_help.txt; echo ""; exit 1
    ;;
  esac
done