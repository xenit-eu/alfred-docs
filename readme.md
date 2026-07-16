# Alfred documentation websites
This used to be a repo building different parts of our documentation website. This has since long been moved to the
individual product repositories, who each build and publish their own part. 

For example https://github.com/xenit-eu/alfred-api publishes https://docs.xenit.eu/alfred-api/.

Now it only contains the landing page for https://docs.xenit.eu/ and old scripts to build the websites. This is kept
with the idea to improve the landing page to something generate with the scrips (to keep a consistent style with
the product documentation pages). 


### Landing page (index)
A directory for the index (landing page at docs.xenit.eu) is located in `docs/index-static`. This is intended to be
temporary. The long-term plan is that this can also be nicely generated from an .md file, but for now we need a fix for
the currently broken index. To deploy this, the directory structure needs to be copied over to the root of the web host.

To deploy see https://xenitsupport.jira.com/wiki/spaces/ST/pages/652378153/A2Hosting+for+www.xenit.eu


## Structure
Submodules are located in `repo/$productName/$productVersion` for each product and product version. The submodule should
be locked to a branch that contains the documentation of a certain version (which probably is a release branch).

Since submodules can not be used to check out a part of a repository, we put symlinks that go to the manuals folders in
the submodules in `docs/$productName/$productVersion`

The `docs/$productName/_hugo` folder contains a configuration file that is used to override the default configuration
of [xenit-markdowntowebsite](https://github.com/xenit-eu/xenit-markdowntowebsite).


## Building
1. Run `build-websites.sh`
2. Websites are available in `build/website`, and an archive in `build/website.tar.gz`
