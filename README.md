# docker-adoptopenjdk8-jre-hotspot

> **DEPRECATED:** this image is no longer maintained and will not receive updates. The last published tag is `432-b06-20250120`, which ships an outdated JRE on Debian Bullseye (end of life). Use the official [`eclipse-temurin`](https://hub.docker.com/_/eclipse-temurin) image instead: it is maintained by the Adoptium project, rebuilt for every security release and published for several architectures.
>
> Migrating usually means changing only the `FROM` line, since `java` is on the `PATH` in both images:
>
> ```dockerfile
> FROM eclipse-temurin:8-jre
> ```
>
> Pin an exact release (for example `eclipse-temurin:8u504-b01-jre`) if you need reproducible builds.

Docker image for AdoptOpenJDK 8 JRE, a project that produces prebuilt binaries from OpenJDK class libraries and a choice of either the OpenJDK HotSpot o Eclipse OpenJ9 VM (<https://adoptopenjdk.net/>). Since July 2021, this project was rebranded as Temurin but this image will keep the AdoptOpenJDK name in order to ensure compatibility with deployments of previous versions.

This image is built upon Debian Bullseye slim image. It offers OpenJDK 8 (LTS) with HotSpot JRE. It's a good choice for running Java applications on modern Linux distros that don't support old OpenJDK versions.

## How to use this image

### As a base image

This image has been specifically designed to be used as a base for other images, enabling you to dockerize applications that need a version 8 JVM. As an example, please have a look at my Docker image for VASSAL (<https://github.com/mablanco/docker-vassal>).

However, nothing prevents it from being used as a CLI standalone tool, as explained below.

### As a standalone tool

Launching a container without parameters will run the JVM and show its version:

```bash
~ docker run -it --rm mablanco/adoptopenjdk8-jre-hotspot
```

In order to run a Java application, mount the application folder and add the full java command:

```bash
~ docker run -it --rm -v <java_app_folder>:/app mablanco/adoptopenjdk8-jre-hotspot java -jar application.jar
```

You can use any JVM argument as long as you mount into the container the folder that hosts the files the JVM is going to work on.

**Note:** Keep in mind that this image won't run applications that need a graphical interface out of the box. You'll need extra tweaks for that. Have a look at <https://github.com/mablanco/docker-vassal> for an example on how to achive this easily.

## Building the image

Use the following command to build the image with the `latest` tag and the AdoptOpenJDK 8 JRE version specified in the Dockerfile:

```bash
~ docker build -t mablanco/adoptopenjdk8-jre-hotspot .
```

In case you want to build a different version, browse the available releases at <https://adoptopenjdk.net/archive.html?variant=openjdk8&jvmVariant=hotspot> and then use this command:

```bash
~ docker build --build-arg OPENJDK_VERSION=<version> --build-arg OPENJDK_SUBVERSION=<subversion> -t mablanco/adoptopenjdk8-jre-hotspot:<version>-<subversion> .
```
