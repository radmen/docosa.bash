# docoseal

[![Build Status](https://travis-ci.org/radmen/docoseal.bash.svg?branch=master)](https://travis-ci.org/radmen/docoseal.bash)

Here's the thing. I use Docker. A lot. What frustrates me are services defined in `docker-compose` and the way how to interact with them.

I have to remember about those flags, arguments order etc. I've already aliased most of them yet, some things can't be simply aliased (like, that's right, `docker-compose` services!).

That's why I decided to write a small utility which will help me by creating shortcuts for each service defined in `docker-compose.yml` file.

# requirements

* bash (tested on `v4.4.19`)
* docker-compose

# installation

1. clone somewhere repository
2. add this lines to `~/.bashrc`
   
   ```
   if test -f ~/path/to/docoseal/init.sh; then
       . ~/path/to/docoseal/init.sh
   fi
   ```
3. (optional) add `.init` alias
   
   ```
   alias .init="eval \$(docoseal env)"
   ```
4. restart bash

# usage

Let's assume that you're in a directory with this `docker-compose.yml` file:

```yml
version: "2"
services:
  web:
    build:
      context: .
      dockerfile: ./docker/Dockerfile
    volumes:
      - ".:/usr/src/app"
    command:
      - pm2-dev
      - process.dev.yml
```

> `web` service is simple [Adonis](http://adonisjs.com) based application

Now, import `docoseal` env:

```bash
eval $(docoseal env)
```

For every service defined in `docker-compose.yml` `docoseal env` will generate `.{SERVICE_NAME}` alias.  
It should be used with one of the defined commands

## run

Runs a command on service container.

```bash
.web run yarn add something
```

Docoseal will run the command on **new** service container.  
It will be removed once command finishes.

`run` command is the default command.  
If no valid command will be applied to alias it will go through `run`.

```bash
.web yarn add something

# same as
.web run yarn add something
```

## exec

Runs the command on running instance of selected service.

```bash
.web exec adonis route:list
```

## restart

Restarts service.

```bash
.web restart
```

## start

Starts service.  

This command accepts options which will be passed to [`docker-compose up`](https://docs.docker.com/compose/reference/up/)

```bash
.web start

# or start it in daemon mode
.web start -d
```

## stop

Stops service.

```bash
.web stop
```

## purge

Stops and removes service containers with its volumes.

```bash
.web purge
```

## reset

Purges service and starts it in daemon mode.

```bash
.web reset
```

## logs

Displays logs of selected service.

This command accepts options which will be passed to [`docker-compose logs`](https://docs.docker.com/compose/reference/logs/)

```bash
.web logs -f
```

# software provided "as is"

I consider `docoseal` as my utility belt. I'll try to improve it, however, my bash knowledge is quite limited.  
It is possible that this script contains some bugs.

Use it on your own responsibility.