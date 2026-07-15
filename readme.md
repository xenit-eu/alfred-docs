# Alfred documentation websites

This repository extensively uses git submodules to pull in documentation files from their respective projects.

You can clone this repository with `git clone --recursive`, or use `git submodule update --init` after cloning the
repository to initialize all submodules.


## Structure

Submodules are located in `repo/$productName/$productVersion` for each product and product version. The submodule should
be locked to a branch that contains the documentation of a certain version (which probably is a release branch).

Since submodules can not be used to check out a part of a repository, we put symlinks that go to the manuals folders in
the submodules in `docs/$productName/$productVersion`

The `docs/$productName/_hugo` folder contains a configuration file that is used to override the default configuration
of [xenit-markdowntowebsite](https://github.com/xenit-eu/xenit-markdowntowebsite).


### Landing page (index)

A directory for the index (landing page at docs.xenit.eu) is located in `docs/index-static`. This is intended to be
temporary. The long-term plan is that this can also be nicely generated from an .md file, but for now we need a fix for
the currently broken index. To deploy this, the directory structure needs to be copied over to the root of the web host.

To deploy: https://xenitsupport.jira.com/wiki/spaces/ST/pages/652378153/A2Hosting+for+www.xenit.eu


## Building

1. Run `build-websites.sh`
2. Websites are available in `build/website`, and an archive in `build/website.tar.gz`


## Adding a new version of a product

1. `git submodule add -b <release-branch> git@bitbucket.org:xenit/<repository>.git repo/<productName>/<versionNumber>`
2. `ln -s ../../repo/<productName>/<versionNumber>/<path-to-docs-directory> docs/<productName>/<versionNumber>`
3. Edit `build-websites.sh` to add a `build_and_split_manual` step for the new
   version: `build_and_split_manual <productName> <versionNumber> <filesForPandoc>`


## Updating a manual of a product version

1. Go to the submodule you want to update `cd repo/<productName>/<versionNumber>`
2. Checkout the commit you want to update to `git fetch && git checkout <commit/tag/branch>`
3. Go back to the main repository `cd ../../..`
4. Add the changes to the submodule `git add repo/<productName>/<versionNumber>`
5. Commit with a message like `Update manuals for <productName> <versionNumber>`


## Deploying documentation websites

Follow deployment instructions in the Wiki page
[A2Hosting for www.xenit.eu](https://xenitsupport.jira.com/wiki/spaces/ST/pages/652378153/A2Hosting+for+www.xenit.eu)
section **docs.xenit.eu**.
