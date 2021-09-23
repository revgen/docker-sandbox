# [docker-sandbox][github-repo]

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

[sandbox-hub]: https://hub.docker.com/r/rev9en/sandbox/
[github-repo]: https://github.com/revgen/docker-sandbox/
