# Docker version 1.11.1
#
# Line blocks used for commenting start with a #.
#
# Default syntax is:
# INSTRUCTION arguments
#
# INSTRUCTIONs are executed by order.

# FROM
#
# It defines the base image to use to start the build process.
# It can be any image.
# If a FROM image is not found on the host, docker will try to find it (and download) from the docker image index.
# It needs to be the first command declared inside a Dockerfile.
#
# Usage: FROM <image_name>:<tag>
# Usage: FROM <image>@<digest>
FROM ubuntu:15.10

# MAINTAINER
#
# It can be set anywhere in the file.
# This non-executing command declares the author of the image.
# It should come nonetheless after FROM.
#
# Usage: MAINTAINER <name and/or email>
MAINTAINER TheodorosPloumis <me@theodorosploumis.com>

# ENV
#
# The ENV command is used to set the environment variables (one or more).
# These variables consist of “key = value” pairs which can be accessed within the container by scripts and applications alike.
# Unlike an ARG instruction, ENV values are always persisted in the built image.
# We can use ENV variables using $VARIABLE for substitution.
#
# Usage: ENV key1 value1 key2 value2
# Usage: ENV key1=value1 key2=value2
# Usage with run: "docker run --env <key>=<value>"
ENV MEMORY 256M

# ARG
#
# The ARG instruction defines a variable that users can pass at build-time to the builder
# with the docker build command using the --build-arg <varname>=<value> flag.
# If an ARG value has a default and if there is no value passed at build-time, the builder uses the default.
# Environment variables defined using the ENV instruction always override an ARG instruction of the same name.
# Docker has a set of predefined ARG variables that you can use without a corresponding ARG instruction in the Dockerfile.
# Such as: HTTP_PROXY, HTTPS_PROXY, FTP_PROXY, NO_PROXY
#
# Usage: ARG <name>[=<default_value>]
# Usage with run: "docker run --build-arg <arg_name>=<value>"
ARG PRESENTATION_NAME="Docker for Developers"

# LABEL
#
# The LABEL instruction adds metadata to an image.
# A LABEL is a key-value pair.
# To include spaces within a LABEL value, use quotes and backslashes as you would in cli parsing.
#
# Usage: LABEL key1 value1 key2 value2
# Usage: LABEL key1=value1 key2=value2
# Usage on the agent CLI: "docker run --label <key>=<value>"
LABEL version="1.0"

# ADD
#
# The ADD command gets two arguments: a source and a destination.
# It copies the files from the source on the host into the container's own filesystem at the set destination.
# If, however, the source is a URL (e.g. http://github.com/user/file/), then the contents of the URL are downloaded and placed at the destination.
#
# Usage: ADD <source_directory or URL> <destination_directory>
ADD /add-local-folder /added-container-folder

# STOPSIGNAL
#
# The STOPSIGNAL instruction sets the system call signal that will be sent to the container to exit.
# This signal can be a valid unsigned number that matches a position in the kernel’s syscall table,
# for instance 9, or a signal name in the format SIGNAME, for instance SIGKILL.
# Usage: STOPSIGNAL <value>
STOPSIGNAL SIGTERM

# EXPOSE
#
# The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime.
# EXPOSE does not make the ports of the container accessible to the host.
# To do that, you must use either the -p flag to publish a range of ports or the -P flag to publish all of the exposed ports.
# You can expose one port number and publish it externally under another number.
# To set up port redirection on the host system, see using the -P flag.
#
# Usage: EXPOSE <port1> <port2> ...
EXPOSE 80 3306

# COPY
#
# The COPY instruction copies new files or directories from <src> and
# adds them to the filesystem of the container at the path <dest>.
# Multiple <src> resource may be specified but they must be relative to the source directory
# that is being built (the context of the build).
# Each <src> may contain wildcards.
#
# Usahe: COPY <src>... <dest>
# Usage: COPY ["<src>",... "<dest>"] (this form is required for paths containing whitespace)
COPY copy-local-folder /copied-container-folder

# USER
#
# The USER instruction sets the USER name or UID to use when running the image and for
# any RUN, CMD and ENTRYPOINT instructions that follow it in the Dockerfile.
#
# Usage: USER <UID or USER_NAME>
USER 1000

# RUN
#
# The RUN instruction will execute any commands in a new layer on top of the current image
# and commit the results, much like source control.
# The resulting committed image will be used for the next step in the Dockerfile.
#
# Usage: RUN <command> (shell form, the command is run in a shell - /bin/sh -c)
# Usage: RUN ["executable", "param1", "param2"] (exec form)
RUN apt-get update && apt-get install vim

# ONBUILD
#
# The ONBUILD instruction adds to the image a trigger instruction to be executed at a later time,
# when the image is used as the base for another build.
# The trigger will be executed in the context of the downstream build,
# as if it had been inserted immediately after the FROM instruction in the downstream Dockerfile.
# Triggers are cleared from the final image after being executed (not inherited by "grand-children" builds).
#
# Usage: ONBUILD [INSTRUCTION]
ONBUILD RUN echo "This is ONBUILD."

# VOLUME
#
# The VOLUME instruction creates a mount point with the specified name and
# marks it as holding externally mounted volumes from native host or other containers.
# The value can be a JSON array, VOLUME ["/var/log/"], or a plain string with multiple arguments, 
# such as VOLUME /var/log or VOLUME /var/log /var/db.
# Paths can be ralative (to WORKDIR) or absolute.
# Anything after the VOLUME instruction in a Dockerfile will not be able to make changes to that volume.
# Data volumes are initialized when a container is created.
# Data volumes can be shared and reused among containers.
# Changes to a data volume are made directly.
# Changes to a data volume will not be included when you update an image.
# Data volumes persist even if the container itself is deleted.
#
# Usage: VOLUME ["/dir_1", "/dir_2", ...]
# Usage: VOLUME /dir_1, /dir_2, ...
VOLUME /added-container-folder /copied-container-folder

# WORKDIR
#
# The WORKDIR instruction sets the working directory for any
# RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
# It can be used multiple times in the one Dockerfile.
# If a relative path is provided, it will be relative to the path of the previous WORKDIR instruction.
#
# Usage: WORKDIR /path/on/container
WORKDIR /var/www/html

# ENTRYPOINT
#
# An ENTRYPOINT allows you to configure a container that will run as an executable.
# Command line arguments to docker run <image> will be appended after all elements in an exec form ENTRYPOINT,
# and will override all elements specified using CMD.
# You can override the ENTRYPOINT instruction using the "docker run --entrypoint <command>" flag.
# Only the last ENTRYPOINT instruction in the Dockerfile will have an effect.
# The default ENTRYPOINT is /bin/sh -c and CMD is passed into that as an argument.
#
# Usage: ENTRYPOINT ["executable", "param1", "param2"] #(exec form, preferred)
# Usage: ENTRYPOINT command param1 param2 #(shell form)
ENTRYPOINT ["top", "-b"]

# CMD
#
# There can only be one CMD instruction in a Dockerfile!
# If you list more than one CMD then only the last CMD will take effect.
# The main purpose of a CMD is to provide defaults for an executing container.
# These defaults can include an executable, or they can omit the executable,
# in which case you must specify an ENTRYPOINT instruction as well.
#
# Usage: CMD ["executable","param1","param2"] #(exec form, this is the preferred form)
# Usege: CMD ["param1","param2"] #(as default parameters to ENTRYPOINT)
# Usage: CMD command param1 param2 #(shell form)
CMD ls
