---
title:
  - Alfred Finder
  - Test Guide
title-slogan:
  - Stop Searching,
  - Start Finding
date: 07/11/2017
document-reference: Finder/Test guide/2.0
document-revision: 0.4
copyright-year: 2018

product-version: 2.0
product-color: 5baaa2
frontpage-background-img: AlfredFinder-FrontCover.jpg
backcover-background-img: AlfredFinder-BackCover.jpg
footer-img: AlfredFinder-Footer-Logo.png

pandoc-args:
    template: manual
numbersections: true
secnumdepth: 4
toc: true
fontawesome: true
---

# Setup

Ensure you git cloned the Alfred Finder project.

* git clone git@bitbucket.org:xenit/finder-xenit.git

Ensure docker and [alfresco-docker-gradle-plugin](https://github.com/xenit-eu/alfresco-docker-gradle-plugin) are installed and configured correctly.

Spin up the integration tests containers:

* ./gradlew :finder-integration-tests:finder-integration-tests-docker:integrationTestComposeUp

browse to localhost:dockerAlfrescoPort/alfresco/s/finder/
Follow this guide to test Alfred Finder.

\include{serverside-config.md}
