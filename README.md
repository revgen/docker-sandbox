# [docker-sandbox][github-repo]

Docker image with developer sandbox, based on Ubuntu Linux.
It contains:
* Python v3.9
* GoLang v1.17
* Node.js v14
* Java v8
* Docker

## Usage

Launch docker container with sandbox:
```bash
session_dir=${HOME}/.local/share/docker-sandbox/${USER}-session
mkdir -p ${session_dir}
docker run -it --rm \
    -p 8000-8999:8000-8999 \
    -v "${session_dir}":/home/shared \
    --name=sandbox rev9en/sandbox
```

If you want to use docker inside the docker image, add a ```--privileged``` parameter into the ```docker run``` command.

[sandbox-hub]: https://hub.docker.com/r/rev9en/sandbox/
[github-repo]: https://github.com/revgen/docker-sandbox/
