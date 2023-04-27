#!/bin/bash
cd "$( dirname "${BASH_SOURCE[0]}" )" # cd to the directory containg the script
exec docker run --rm -v "$(pwd)/..:/manual" -w /manual/user hub.xenit.eu/private/xenit-markdowntopdf:latest \
    user-guide.md -o user-guide.pdf \
    --resource-path .:../shared-assets
