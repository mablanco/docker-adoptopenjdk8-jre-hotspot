# docker-adoptopenjdk8-jre-hotspot

Docker image for AdoptOpenJDK 8 JRE, a project that produces prebuilt binaries from OpenJDK class libraries and a choice of either the OpenJDK HotSpot o Eclipse OpenJ9 VM (<https://adoptopenjdk.net/>).

This image is built upon Debian Buster slim image. It offers OpenJDK 8 (LTS) with HotSpot JRE. It's a good choice for running Java applications on modern Linux distros that don't support old OpenJDK versions.

## How to use this image

### As a base image

This image has been specifically designed to be used as a base for other images, enabling you to dockerize applications that need a version 8 JVM. As an example, please have a look at my Docker image for VASSAL (<https://github.com/mablanco/docker-vassal>).

However, nothing prevents it from being used as a CLI standalone tool, as explained below.

### As a standalone tool

Launching a container without parameters will run the JVM and show its version:

    $ docker run -it --rm mablanco/adoptopenjdk8-hotspot

In order to run a Java application, mount the application folder and add the full java command:

    $ docker run -it --rm -v <java_app_folder>:/app mablanco/adoptopenjdk8-hotspot java -jar application.jar

You can use any JVM argument as long as you mount into the container the folder that hosts the files the JVM is going to work on.

**Note:** Keep in mind that this image won't run applications that need a graphical interface out of the box. You'll need extra tweaks for that. Have a look at <https://github.com/mablanco/docker-vassal> for an example on how to achive this easily.

## Building the image

Use the following command to build the image with the `latest` tag and the AdoptOpenJDK 8 JRE version specified in the Dockerfile:

    $ docker build -t mablanco/adoptopenjdk8-jre-hotspot .

In case you want to build a different version, browse the available releases at <https://adoptopenjdk.net/archive.html?variant=openjdk8&jvmVariant=hotspot> and then use this command:

    $ docker build --build-arg OPENJDK_VERSION=<version> --build-arg OPENJDK_SUBVERSION=<subversion> -t mablanco/adoptopenjdk8-jre-hotspot:<version>-<subversion> .
