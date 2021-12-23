#!/ur/bin/env bash
set -e
read -p "The script is installing GoLang. Continue (y/N)? " opt
[ "${opt}" != "y" ] && echo "Skip" && exit 1

curl -sL https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar -xz -C /usr/local && \
echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile.d/golang.sh
echo "Done"

go version
