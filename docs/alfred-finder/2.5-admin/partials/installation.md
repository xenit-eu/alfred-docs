# Installation

Alfred Finder can be installed inside Alfresco as an AMP, or can be run on a separate webserver.

## Pre-requisites

Alfred Finder requires **Alfred API**, version 2.7.1 or later. This module should be installed in Alfresco before Alfred Finder can be used. Installation instructions can be found in the [Alfred API documentation](https://docs.xenit.eu/alfred-api/stable-user/installation/).

## Installation in Alfresco (AMP)

Installing Alfred Finder in Alfresco is the easiest way to get started if you have a stand-alone Alfresco repository.

An AMP or Dynamic Extensions JAR can be obtained from the Xenit Artifactory server, in the `eu.xenit.finder:finder-embedded:<version>` module.

The Alfred Finder AMP can be installed according to the [Alfresco AMP installation documentation](https://docs.alfresco.com/content-services/6.0/install/zip/amp/).

Alternatively, after [**Dynamic Extensions for Alfresco**](https://github.com/xenit-eu/dynamic-extensions-for-alfresco) is installed in Alfresco (a requirement of Alfred API), the Alfred Finder Dynamic Extensions JAR can be uploaded in the Dynamic Extensions dashboard.

After installation, Alfred Finder is available for authenticated users on `/alfresco/s/finder/`.

## Installation with a Docker container

When Alfresco is installed in a Dockerized environment with a proxy in front of Alfresco, the easiest way to get started is by deploying a separate Docker container with Alfred Finder.

The Alfred Finder Docker image is available on `hub.xenit.eu/alfred-finder/finder-app:<version>`.

The Docker image contains a webserver that serves the Alfred Finder application on `/`.

It is recommended that the proxy is configured to forward traffic with prefix `/finder/` (or a different prefix if desired) to the Alfred Finder container.

The `serviceUrl` environment variable can be modified to change the location of the Alfresco repository if it is configured on a different hostname or context. The default configuration assumes that the Alfresco repository is accessible on the same hostname with base-path `/alfresco/`.

> **Note**: In case the Alfresco repository is configured on a different hostname, correct Cross-Origin Resource Sharing (CORS) headers MUST be configured to allow Alfred Finder to access and authenticate against the Alfresco repository.

## Installation on a webserver

Alfred Finder can also installed on a separate webserver.

This approach allows for installing multiple instances with different configuration for the same Alfresco repository.

Alfred Finder is a static web application without server-side programming.
It is sufficient to extract the Alfred Finder ZIP to a folder that is configured as a subfolder of the document root in the webserver.

The Alfred Finder ZIP can be obtained from the Xenit Artifactory server, in the `eu.xenit.finder:finder-app:<version>:static` module.

The `resources/static/config.js` file can be modified to change the `serviceUrl` in case the Alfresco repository is configured on a different hostname or context.

> **Note**: In case the Alfresco repository is configured on a different hostname, correct Cross-Origin Resource Sharing (CORS) headers MUST be configured to allow Alfred Finder to access and authenticate against the Alfresco repository.
