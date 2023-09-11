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

# Both Alfred API Javadoc and Swagger doc are built by the git submodule of the 'alfred-api' repository
build_alfredapi_javadoc() {
    local alfredapidir="repo/alfred-api/stable"
    pushd "$alfredapidir"
    ./gradlew clean :apix-interface:javadoc
    popd

    local outputdir="build/website/alfred-api/stable-user"
    mkdir -p "$outputdir"
    cp -a "$alfredapidir/apix-interface/build/docs/javadoc" $outputdir
}

build_alfredapi_swaggerdoc() {
    local swaggeruidir="swagger-ui"
    local outputdir="build/website/alfred-api/stable-user"
    cp -a ${swaggeruidir} ${outputdir}

    local alfredapidir="repo/alfred-api/stable"
    sleep  5
    ls -l ${alfredapidir}
    ${alfredapidir}/gradlew --project-dir ${alfredapidir} --quiet :swagger-doc-extractor:run > "${outputdir}/${swaggeruidir}/swagger.json"
}

rm -rf build/

# Desktop
build_docx_manual alfred-desktop 4.2 "Alfred Desktop User Guide 4.2.docx"
#split_manual alfred-desktop 4.2
build_docx_manual alfred-desktop 4.1 "Alfred Desktop User Guide 4.1.docx"
#split_manual alfred-desktop 4.1
build_docx_manual alfred-desktop 4.0 "Alfred Desktop User Guide 4.0.docx"
#split_manual alfred-desktop 4.0
#build_product_website alfred-desktop

find build/website -type f -name '*.html' -print0 | xargs -0 sed -i "/^<\!DOCTYPE html>$/a\
\<\!-- alfred-docs@$(git describe --always --dirty) --\>"

tar czf build/website.tar.gz -C build/website .
