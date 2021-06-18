#!/bin/bash
set -e
scriptPath="$( dirname "${BASH_SOURCE[0]}" )" # cd to the directory containg the script
cd "$scriptPath"
MARKDOWNTOPDF_VERSION=build-201911121900-1
MARKDOWNTOWEBSITE_VERSION=1.0.0-SNAPSHOT-202010231216-2

WEIGHT=0

build_manual() {
    local productName="$1"
    local versionName="$2"
    shift 2;

    mkdir -p "build/normalized/$productName"
    tar c --portability -C "docs/$productName/$versionName" . | \
    docker run --rm -i hub.xenit.eu/private/xenit-markdowntopdf:$MARKDOWNTOPDF_VERSION --tar \
    --template default -t markdown-simple_tables --extract-media assets \
    --resource-path . \
    "$@" \
    -o normalized.md > "build/normalized/$productName/$versionName.tar"
    sync
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
    sync
}

split_manual() {
    local productName="$1"
    local versionName="$2"
    WEIGHT=$[$WEIGHT + 1]
    mkdir -p "build/product/$productName"
    tar tf "build/normalized/$productName/$versionName.tar"
    cat "build/normalized/$productName/$versionName.tar" | docker run --rm -i hub.xenit.eu/private/xenit-manuals-markdown-splitter:$MARKDOWNTOWEBSITE_VERSION normalized.md "target-path=$versionName" "weight=$WEIGHT" > "build/normalized/$productName/$versionName-out.tar"
    sync
    tar xf "build/normalized/$productName/$versionName-out.tar" -C "build/product/$productName"
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
        docker run --rm -i hub.xenit.eu/private/xenit-manuals-hugo-generator:$MARKDOWNTOWEBSITE_VERSION | \
        tar x -C "build/website/$productName"
    sync
}

# the javadoc jar for alfredapi interface is published on maven central.
# given the assumption that publishing a new version happens before updating the docs, we can retrieve the latest version
# of the jar from there and unzip it to include it in the website.
unzip_alfredapi_javadoc() {
    local javadocdir="build/website/alfred-api/stable-user/javadoc"
    mkdir -p "$javadocdir"
    curl -L -o "$javadocdir/apix-interface-javadoc.jar" \
        https://search.maven.org/remotecontent?filepath=eu/xenit/apix/apix-interface/2.7.0/apix-interface-2.7.0-javadoc.jar
    unzip "$javadocdir/apix-interface-javadoc.jar" -d "$javadocdir"
    rm "$javadocdir/apix-interface-javadoc.jar"
}

rm -rf build/

# Desktop
build_docx_manual alfred-desktop 4.0 "Alfred Desktop User Guide 4.0.docx"
split_manual alfred-desktop 4.0
build_docx_manual alfred-desktop 3.8 "Alfred Desktop User Guide 3.8.docx"
split_manual alfred-desktop 3.8
build_docx_manual alfred-desktop 3.7 "Alfred Desktop User Guide 3.7.docx"
split_manual alfred-desktop 3.7
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
build_and_split_manual alfred-finder 2.2-user "user-guide.md"
build_and_split_manual alfred-finder 2.2-admin "admin-guide.md"
build_and_split_manual alfred-finder 2.1-user "user-guide.md"
build_and_split_manual alfred-finder 2.1-configuration "configuration-guide.md"
build_product_website alfred-finder

# Edge
build_and_split_manual alfred-edge 1.1 "main.md"
build_and_split_manual alfred-edge 1.0 "main.md"
build_product_website alfred-edge


# Inflow
build_and_split_manual alfred-inflow 3.4-user "user-guide.md"
build_and_split_manual alfred-inflow 3.4-developer "developer-guide.md"
build_and_split_manual alfred-inflow 3.4-installation "installation-guide.md"
build_and_split_manual alfred-inflow 3.3-user "user-guide.md"
build_and_split_manual alfred-inflow 3.3-developer "developer-guide.md"
build_and_split_manual alfred-inflow 3.3-installation "installation-guide.md"
build_and_split_manual alfred-inflow 3.1-user "user-guide.md"
build_and_split_manual alfred-inflow 3.1-developer "developer-guide.md"
build_and_split_manual alfred-inflow 3.1-installation "installation-guide.md"
build_and_split_manual alfred-inflow 3.0 "user-guide.md"
build_product_website alfred-inflow

# Api
build_and_split_manual alfred-api stable-user "user-guide.md"
build_product_website alfred-api
unzip_alfredapi_javadoc

find build/website -type f -name '*.html' -print0 | xargs -0 sed -i "/^<\!DOCTYPE html>$/a\
\<\!-- alfred-docs@$(git describe --always --dirty) --\>"

tar czf build/website.tar.gz -C build/website .
