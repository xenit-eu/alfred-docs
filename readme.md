# Alfred documentation websites

This repository extensively uses git submodules to pull in documentation files from their respective projects.

You can clone this repository with `git clone --recursive`, or use `git submodule init && git submodule update` after cloning the repository
to initialize all submodules.

## Structure

Submodules are located in `repo/$productName/$productVersion` for each product and product version.
The submodule should be locked to a branch that contains the documentation of a certain version (which probably is a release branch).

Since submodules can not be used to check out a part of a repository, we put symlinks that go to the manuals folders in the submodules in `docs/$productName/$productVersion`

The `docs/$productName/_hugo` folder contains a configuration file that is used to override the default configuration of [xenit-markdowntowebsite](https://bitbucket.org/xenit/xenit-markdowntowebsite).

## Building

1. Run `build-websites.sh`
2. Websites are available in `build/website`, and an archive in `build/website.tar.gz`

## Adding a new version of a product

1. `git submodule add -b <release-branch> git@bitbucket.org:xenit/<repository>.git repo/<productName>/<versionNumber>`
2. `ln -s ../../repo/<productName>/<versionNumber>/<path-to-docs-directory> docs/<productName>/<versionNumber>`
3. Edit `build-websites.sh` to add a `build_and_split_manual` step for the new version: `build_and_split_manual <productName> <versionNumber> <filesForPandoc>`
