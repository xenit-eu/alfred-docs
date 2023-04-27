#!/bin/bash
cd "$( dirname "${BASH_SOURCE[0]}" )" # cd to the directory containg the script
exec docker run --rm -v "$(pwd)/..:/manual" -w /manual/admin hub.xenit.eu/private/xenit-markdowntopdf:latest \
    admin-guide.md -o admin-guide.pdf \
    --resource-path .:../shared-assets
