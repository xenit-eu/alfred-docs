#!/bin/bash
set -e
scriptPath="$( dirname "${BASH_SOURCE[0]}" )" # cd to the directory containg the script
cd "$scriptPath"
MARKDOWNTOPDF_VERSION=build-201804121240-56
MARKDOWNTOWEBSITE_VERSION=build-201804191059-4

build_manual() {
    local productName="$1"
    local versionName="$2"
    shift 2;

    tar c -C "docs/$productName/$versionName" . | \
    docker run --rm -i hub.xenit.eu/xenit-markdowntopdf:$MARKDOWNTOPDF_VERSION --tar \
    --template default -t markdown-simple_tables --extract-media assets \
    --resource-path . \
    "$@" \
    -o normalized.md > "build/normalized/$productName/$versionName.tar"
}

build_docx_manual() {
    local productName="$1"
    local versionName="$2"
    local title="$4"
    local buildDir="build/product/$productName/$versionName"
    mkdir -p "$buildDir"
    local currentPath="$(pwd)"
    pushd "$buildDir" > /dev/null
    pandoc -t markdown-simple_tables --extract-media "assets" "$currentPath/docs/$productName/$versionName/$3" -o "extracted.md" 1>&2
    popd  > /dev/null
    cat - "$buildDir/extracted.md"  > "$buildDir/normalized.md" <<EOL
---
product-version: "$versionName"
title: "$title"
---
EOL
    tar c -C "$buildDir" . > "build/normalized/$productName/$versionName.tar"
}

split_manual() {
    local productName="$1"
    local versionName="$2"
    mkdir -p "build/product/$productName"
    < "build/normalized/$productName/$versionName.tar" docker run --rm -i hub.xenit.eu/xenit-manuals-markdown-splitter:$MARKDOWNTOWEBSITE_VERSION normalized.md "target-path=$versionName" | \
    tar x -C "build/product/$productName"
}

build_and_split_manual() {
    build_manual "$@"
    split_manual "$1" "$2"
}

build_product_website() {
    local productName="$1"
    mkdir -p "build/website/$productName"
    cp -r "docs/$productName/_hugo" "build/product/$productName/_hugo"
    tar c -C "build/product/$productName" . | \
        docker run --rm -i hub.xenit.eu/xenit-manuals-hugo-generator:$MARKDOWNTOWEBSITE_VERSION | \
        tar x -C "build/website/$productName"
}

rm -rf build/

# Desktop
build_docx_manual desktop 3.6 "Alfred Desktop User Guide 3.6.docx" "Alfred Desktop Manual"
split_manual desktop 3.6
build_product_website desktop

# Edge
build_and_split_manual edge 1.0 metadata.md main.md
build_product_website edge

# Finder
build_and_split_manual finder 2.0-configuration "configuration-guide.md"
build_and_split_manual finder 2.0-user "user-guide.md"
build_product_website finder

# Inflow
build_and_split_manual inflow 3.0 "metadata.md" "user-guide.md"
build_product_website inflow

tar czf build/website.tar.gz -C build/website .
