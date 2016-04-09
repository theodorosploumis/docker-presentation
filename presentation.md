![Docker carries Python meetup!](https://avatars2.githubusercontent.com/u/18222668)

## Docker for Developers

#### [Python Meetup Thessaloniki](http://www.meetup.com/PyThess/), 15 April 2016

[docker.com](http://docker.com)

<small>[TheodorosPloumis.com](http://www.theodorosploumis.com/en) / [@theoploumis](twitter.com/theoploumis)</small><br>
<small>Get the presentation [online](https://thess-docker.github.io/slides)/[source](https://github.com/thess-docker/slides)</small>

---

### Let me ask you

- Who knows about Docker?
- Who uses Docker for development?
- Who uses Docker in production?
- Who tried but could not do it?

---

### What is Docker (v1.9)

<section>
  <blockquote>
    Docker is an open platform for developing, shipping, and running applications.
    <br><br>
    Docker allows you to package an application with all of its dependencies into a standardized unit for software development.
  </blockquote>
</section>

<section>
  <a href="https://www.docker.com/sites/default/files/what-is-vm-diagram.png"><img src="https://www.docker.com/sites/default/files/what-is-vm-diagram.png" title="Docker stack"></a>
</section>

---

### Docker History

 - Solomon Hykes ([@solomonstre](https://twitter.com/solomonstre))
 - dotCloud (now Docker Inc)
 - March 2013
 - Apache 2.0 license
 - 30k stars on Github
 - Docker Inc acquires everyone <small><sup>TM</sup></small>

---

### Docker Benefits

 - Fast (deployment, migration, restarts)
 - Secure
 - Lightweight (save disk & CPU)
 - Open Source
 - Portable software
 - Microservices and integrations (APIs)
 - Simplify DevOps
 - Version control capabilities

---

### Common Docker usages

 - Rapid building
 - Debugging/Testing
 - Continuous Integration & Deployment
 - Scaling
 - Development collaboration
 - System configuration
 - Local development
 - Multi-tier applications
 - PaaS & SaaS infrastructure and/or apps

---

### [Technology behind Docker](https://docs.docker.com/engine/understanding-docker/)

 - Linux x86-64
 - Go language
 - Client - Server (deamon) architecture
 - Union file systems (UnionFS: AUFS, btrfs, vfs etc)
 - Namespaces (pid, net, ipc, mnt, uts)
 - Control Groups (cgroups)
 - Container format (libcontainer)

---

### The Docker architecture

<img src="https://docs.docker.com/engine/article-img/architecture.svg" title="Docker architecture">
<small>See more at [Understanding docker](https://docs.docker.com/engine/understanding-docker/)</small>

---

### Docker components

 - (Docker) client
 - deamon
 - engine
 - machine
 - compose
 - swarm
 - registry

---

### Docker client

It is the primary user interface to Docker. It accepts commands from the user
and communicates back and forth with a Docker daemon.

---

### Docker daemon

It runs on a host machine. The user does not directly interact with the daemon,
but instead through the Docker client with the RESTful api or sockets.

---

### Docker engine

A Client with a Daemon as also as the docker-composer. Usually referred simply as "docker".

---

### Docker machine

A tool which makes it really easy to create Docker hosts on your computer,
on cloud providers and inside your own data center.
It creates servers, installs Docker on them, then configures the Docker client to talk to them.
Required for Mac, Windows users.

---

### Docker compose

A tool for defining and running complex applications with Docker
(eg a multi-container application) with a single file.

---

### Docker swarm
A native clustering tool for Docker. Swarm pools together several Docker
hosts and exposes them as a single virtual Docker host. It scale up to multiple hosts.

---

### Docker registry
A (hosted) service containing repositories of images which responds to the Registry API.

---

### Docker Commands

```bash
// General info
docker [COMMAND] --help
docker info
docker version
docker network ls

// Images
docker images
docker export // import
docker build

// Containers
docker ps // -a, -l
docker stop/start/restart [CONTAINER]
docker stats [CONTAINER]
docker top [CONTAINER]
docker port [CONTAINER]
docker inspect [CONTAINER]
docker inspect -f "{{ .State.StartedAt }}" [CONTAINER]
docker rm [CONTAINER]
docker diff
docker commit

```

---

### Steps of a Docker workflow

```
docker run -i -t ubuntu /bin/bash
```

 - Pulls the ubuntu <abbr title="A read-only layer that is the base of your container. It can have a parent image to abstract away the more basic filesystem snapshot.">image</abbr> from the <abbr title="The central place where all publicly published images live. You can search it, upload your images there and when you pull a docker image, it comes the repository/hub.">registry</abbr>
 - Creates a new <abbr title="A runnable instance of the image, basically it is a process isolated by docker that runs on top of the filesystem that an image provides.">container</abbr>
 - Allocates a filesystem and mounts a read-write <abbr title="A set of read-only files to provision the system. Think of a layer as a read only snapshot of the filesystem.">layer</abbr>
 - Allocates a network / bridge interface
 - Sets up an <abbr title="An Internet Protocol address (IP address) is a numerical label assigned to each device (e.g., computer, printer) participating in a computer network that uses the Internet Protocol for communication.">IP address</abbr>
 - Executes a process that you specify (<code>/bin/bash</code>)
 - Captures and provides application output

---

### Dockerfile

> A Dockerfile is a text document that contains all the commands a user could call on the command line to create an image.

 - Official [Dockerfile reference](https://docs.docker.com/engine/reference/builder/)
 - [Inline docs](examples/dockerfile/Dockerfile) of an example Dockerfile
 - Real Dockerfiles ([rails](https://github.com/docker-library/rails/blob/master/Dockerfile), [nodejs](https://github.com/ReadyTalk/nodejs-docker/blob/master/base/Dockerfile), [django](https://github.com/docker-library/django/blob/master/3.4/Dockerfile), [Drupal](https://github.com/docker-library/drupal/blob/master/8.1/fpm/Dockerfile))

---

### Docker examples

- Showcase a project
- SSH into a container
- Build an Image
- Docker [Volume](https://docs.docker.com/engine/userguide/containers/dockervolumes/)
- [Linked](https://docs.docker.com/engine/userguide/networking/default_network/dockerlinks/) containers
- Using docker [Compose](https://docs.docker.com/compose/)
- Package an app with its environment (tar)
- Share an image (public, this presentation)
- Testing usage (travis.ci)

---

### Example: Showcase
<pre><code>docker pull supertest2014/nyan
docker run --rm -it supertest2014/nyan
</pre></code>

---

### Example: SSH into a container
<pre><code>docker pull ubuntu
docker run -it --name python_meetup ubuntu /bin/bash
</pre></code>

---

### Example: Build an Image

Let's build a [jenkins image](https://github.com/thess-docker/komljen-dockerfile-examples/blob/master/jenkins/Dockerfile)

<pre><code>cd ~/Docker-presentation
git clone git@github.com:thess-docker/komljen-dockerfile-examples.git
cd komljen-dockerfile-examples/jenkins
docker build -t jenkins-local .

// Test it
docker run -d -p 8099:8080 --name jenkins_example jenkins-local
// Open http://localhost:8099
</pre></code>

---

### Example: Docker volume

Let's use [Apache server](https://bitbucket.org/EdBoraas/apache-docker/src/)

<pre><code>cd ~/Docker-presentation
mkdir apache-example
cd apache-example

docker pull eboraas/apache
docker run --name apache_example \
           -p 8180:80 -p 443:443 \
           -v $(pwd):/var/www/ \
           -d eboraas/apache

// Create an index.html file
mkdir html && cd html
echo "It works using linux mount..." >> index.html

// Open http://localhost:8180 to view the html file
</pre></code>

---

### Example: Docker link containers

Let's create a [Drupal app](https://hub.docker.com/_/drupal/) (apache, php, mysql, drupal)

<pre><code>cd ~/Docker-presentation
mkdir drupal-link-example
cd drupal-link-example

docker pull drupal:8.0.6-apache
docker pull mysql:5.5

// Start a container for mysql
docker run --name mysql_example \
           -e MYSQL_ROOT_PASSWORD=root \
           -e MYSQL_DATABASE=drupal \
           -e MYSQL_USER=drupal \
           -e MYSQL_PASSWORD=drupal \
           -d mysql:5.5

// Start a Drupal container and link it with mysql
// Usage: --link <name or id>:alias
docker run --name drupal_example \
           -p 8280:80 \
           --link mysql_example:mysql \
           -d drupal:8.0.6-apache

// Open http://localhost:8280 to continue with the installation
// On the db host use: mysql

// See the linking
docker inspect -f "{{ .HostConfig.Links }}" drupal_example
</pre></code>

---

### Example: Using Docker Compose
Let's create a [Drupal app](https://hub.docker.com/_/drupal/) even more easily...

<pre><code>cd ~/Docker-presentation
git clone git@github.com:thess-docker/slides.git
cd slides/docker-compose

// Run docker-compose using the docker-compose.yml
cat docker-compose.yml
docker-compose up -d -f docker-compose.yml
</pre></code>

---

### Example: Push an Image to a registry

<pre><code>cd ~/Docker-presentation
git clone git@github.com:thess-docker/slides.git
cd slides

docker pull nimmis/alpine-apache
docker build -t tplcom/docker-presentation .

// Test it
docker run -itd --name docker_presentation -p 8480:80 tplcom/docker-presentation
// Open http://localhost:8480, you should see this presentation

// Push it on the hub.docker.com

</pre></code>

---

### Docker tips

There are known best practices ([1](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/), [2](http://crosbymichael.com/dockerfile-best-practices.html), [3](http://crosbymichael.com/dockerfile-best-practices-take-2.html), [4](https://github.com/replicatedhq/dockerfilelint#checks-performed), [5](https://getcarina.com/docs/best-practices/docker-best-practices-dockerfile/))

- Optimize containers (check [fromlatest.io](https://www.fromlatest.io/) and [imagelayers.io](https://imagelayers.io))
- Create your own tiny base
- Containers are not Virtual Machines
- Full stack Images vs 1 process per Container
- Create your private registry
- Create shortcut commands
- Be aware of the hub.docker.com agent version

---

### The Docker war

| Type | Software |
|:----:|----------|
| Clustering/orchestration | [Swarm](https://docs.docker.com/swarm/), [Kubernetes](http://kubernetes.io/), [Marathon](https://mesosphere.github.io/marathon/), [MaestroNG](https://github.com/signalfx/maestro-ng), [decking](http://decking.io/), [shipyard](http://shipyard-project.com/) |
| Docker registries | [Portus](http://port.us.org/), [Docker Distribution](https://github.com/docker/distribution), [hub.docker.com](http://hub.docker.com), [quay.io](https://quay.io), [Google container registry](https://cloud.google.com/tools/container-registry/), [Artifactory](https://www.jfrog.com/artifactory/) |
| PaaS based on Docker | [Rancher](http://rancher.com/), [Tsuru](https://tsuru.io/), [Octohost](http://octohost.io/), [DEIS](http://deis.io/) |

---

### Docker Alternatives

- [Rocket](https://github.com/coreos/rkt)
- [Linux Containers](https://linuxcontainers.org/)
- [drawbridge](http://research.microsoft.com/en-us/projects/drawbridge/)
- [lcd](http://www.ubuntu.com/cloud/lxd)
- [Project Calico](https://www.projectcalico.org/)

---

### Instead of Resources

 - [Awesome Docker](https://github.com/veggiemonk/awesome-docker) (list of Docker resources & projects)
 - [Docker cheat sheet](https://github.com/wsargent/docker-cheat-sheet)
 - [Docker in Practice](https://www.manning.com/books/docker-in-practice) (book)

---

### Questions?

<small>Upcoming: Docker in production, Scaling Containers, Private registry, PaaS with Docker.</small>
<small>In this presentation I have used [wharfee](https://github.com/j-bennet/wharfee) and [dry](https://github.com/moncho/dry).</small>

---

### Bonus!

![Docker logo](img/docker_logo.png)

> The [SKGTech.io docker image](https://github.com/skgtech/skgtech.io-docker)
