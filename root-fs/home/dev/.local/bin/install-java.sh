#!/ur/bin/env bash
set -e
read -p "The script is installing Java. Continue (y/N)? " opt
[ "${opt}" != "y" ] && echo "Skip" && exit 1

apt -y install default-jdk && \
java -version
