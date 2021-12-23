#!/ur/bin/env bash
set -e
read -p "The script is installing AWS v2. Continue (y/N)? " opt
[ "${opt}" != "y" ] && echo "Skip" && exit 1

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "aws.zip" && \
unzip aws.zip && sudo ./aws/install && rm -r aws*
echo "Done"
aws --version
