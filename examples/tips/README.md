### Docker tips and best practices

Here are some basic tips and best practices for writing Dockerfiles,
building docker Images and using Docker in general. Feel free to add your suggestions
with a pull request.

- Create Dockerfiles with cache (of the layers) in mind.
- Use empty lines, comments and backslashes ("\") for readability.
- Keep each image layer "atomic".
- Optimize containers (check [fromlatest.io](https://www.fromlatest.io/) and [imagelayers.io](https://imagelayers.io)).
- Containers are not Virtual Machines.
- Think of creating your own private registry.
- Use docker-compose.yml templates if you need permanent containers.
- Be aware of the hub.docker.com agent version (different versions need different Dockerfile).
- Group common operations under the same instruction.
- Don't install useless software.
- Keep images small and unique.
- Search for similar public images before creating your own.
- When you need software to install another software remove the first after the build.
- Uppercase the Dockerfile instructions.
- Split the Dockerfile instructions while developing your Dockerfile and merge them when you are ready to publish it.
- Split multiprocess images to several images with one process per images.
- Use ADD and VOLUME at the end of the Dockerfile (except if files are needed before).
- If you have multiple Dockerfile steps that use different files from your context, ```COPY``` them individually, rather than all at once.
- Prefer using an ENTRYPOINT always.
- Install specific versions of software.
- With COPY the directories are not copied, only their files.
- When using a base image choose a specific tag (avoid default tag "latest").
- Never map directly the public port inside a Dockerfile.
- Prefer using the array syntax for CMD, ENTRYPOINT etc (```CMD [...]```).
- Prefer the tiny base images (busybox, alpine, tinycore, baseimage etc).
- Build your own base image when you want full control of the Dockerfile.
- Things that do not change ofter should stay on top of the Dockerfile (eg MAINTAINER).
- If you need to work with local files use VOLUME and not ADD.
- Test builds locally before triggering automated builds on online docker registries.
- Use ```Dockerfile``` for infrastructure and ```docker-compose``` for tasks.
- Regex used in Dockerfiles are from Go language.
- Never do things like ```apt-get upgrade``` inside a Dockerfile.
- Containers should model processes and not virtual machines.
- Create local shortcut/aliases for common docker commands and workflows.
- Be careful with volumes. When docker mounts folders on read-write mode your files may be deleted.
- A volume will never be deleted as long as a container is linked to it.
- Use shell scripts for complicated RUN commands on the Dockerfile as also as for starting processes on containers.
- Running the same image multiple times does not add multiple images on the host disk (```1x ubuntu:latest == 100x ubuntu:latest```).
- Avoid using a GUI. CLI makes it easier to understand the Docker philosophy.
- Prefer running processes inside containers with a non ROOT user for security reasons.

#### Resources

- [Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
- (07/2013) [Dockerfile Best Practices, Part 1](http://crosbymichael.com/dockerfile-best-practices.html)
- (03/2014) [Dockerfile Best Practices, Part 2](http://crosbymichael.com/dockerfile-best-practices-take-2.html)
- (07/2014) [10 Docker Tips and Tricks That Will Make You Sing A Whale Song of Joy](http://nathanleclaire.com/blog/2014/07/12/10-docker-tips-and-tricks-that-will-make-you-sing-a-whale-song-of-joy/)
- [Linter and validator for Dockerfile](https://github.com/replicatedhq/dockerfilelint#checks-performed)
- (10/2015) [Docker best practices: Dockerfile](https://getcarina.com/docs/best-practices/docker-best-practices-dockerfile/)
- (12/2014) [Understanding Volumes in Docker](http://container-solutions.com/understanding-volumes-docker/)
- [Manage data in containers](https://docs.docker.com/engine/userguide/containers/dockervolumes/)
- (18 Nov 2014) [Data-only container madness](http://container42.com/2014/11/18/data-only-container-madness/)
