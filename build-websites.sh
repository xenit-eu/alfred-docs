#!/bin/bash
set -e
scriptPath="$( dirname "${BASH_SOURCE[0]}" )" # cd to the directory containg the script
cd "$scriptPath"
MARKDOWNTOPDF_VERSION=build-201804121240-56
MARKDOWNTOWEBSITE_VERSION=1.0.0-SNAPSHOT-201805020926-12

WEIGHT=0

build_manual() {
    local productName="$1"
    local versionName="$2"
    shift 2;

    mkdir -p "build/normalized/$productName"
    tar c --portability -C "docs/$productName/$versionName" . | \
    docker run --rm -i hub.xenit.eu/xenit-markdowntopdf:$MARKDOWNTOPDF_VERSION --tar \
    --template default -t markdown-simple_tables --extract-media assets \
    --resource-path . \
    "$@" \
    -o normalized.md > "build/normalized/$productName/$versionName.tar"
}

build_docx_manual() {
    local productName="$1"
    local versionName="$2"
    local buildDir="build/docx/$productName/$versionName"
    mkdir -p "$buildDir"
    local currentPath="$(pwd)"
    pushd "$buildDir" > /dev/null
    pandoc -t markdown-simple_tables --extract-media "assets" "$currentPath/docs/$productName/$versionName/$3" -o "extracted.md" 1>&2
    popd > /dev/null
    cat "docs/$productName/$versionName/metadata.yaml" "$buildDir/extracted.md"  > "$buildDir/normalized.md"
    rm "$buildDir/extracted.md"
    mkdir -p "build/normalized/$productName"
    tar cf "build/normalized/$productName/$versionName.tar" --portability -C "$buildDir" .
}

split_manual() {
    local productName="$1"
    local versionName="$2"
    WEIGHT=$[$WEIGHT + 1]
    mkdir -p "build/product/$productName"
    < "build/normalized/$productName/$versionName.tar" docker run --rm -i hub.xenit.eu/xenit-manuals-markdown-splitter:$MARKDOWNTOWEBSITE_VERSION normalized.md "target-path=$versionName" "weight=$WEIGHT" | \
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
    tar c --portability -C "build/product/$productName" . | \
        docker run --rm -i hub.xenit.eu/xenit-manuals-hugo-generator:$MARKDOWNTOWEBSITE_VERSION | \
        tar x -C "build/website/$productName"
}

rm -rf build/

# Desktop
build_docx_manual alfred-desktop 3.6 "Alfred Desktop User Guide 3.6.docx"
split_manual alfred-desktop 3.6
build_docx_manual alfred-desktop 3.5 "Fred User Guide 3.5.docx"
split_manual alfred-desktop 3.5
build_docx_manual alfred-desktop 3.4 "Fred User Guide 3.4.docx"
split_manual alfred-desktop 3.4
build_docx_manual alfred-desktop 3.3 "Fred User Guide 3.3.docx"
split_manual alfred-desktop 3.3
build_docx_manual alfred-desktop 3.2 "Fred User Guide Trial 3.2.docx"
split_manual alfred-desktop 3.2
build_product_website alfred-desktop

# Finder
build_and_split_manual alfred-finder 2.0-user "user-guide.md"
build_and_split_manual alfred-finder 2.0-configuration "configuration-guide.md"
build_product_website alfred-finder

find build/website -type f -name '*.html' -print0 | xargs -0 sed -i "/^<\!DOCTYPE html>$/a\
\<\!-- alfred-docs@$(git describe --always --dirty) --\>"

tar czf build/website.tar.gz -C build/website .
