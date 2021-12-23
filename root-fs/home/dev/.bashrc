# If not running interactively, don't do anything
[ -z "$PS1" ] && return

printf "\e[92m"
echo '───────────────────────────────────────────────────────'
if [ -f "${HOME}/.local/welcome" ]; then
    cat "${HOME}/.local/welcome"
    echo "───────────────────────────────────────────────────────"
fi
printf "\e[0m"
printf "${IMAGE_NAME} v${BUILD_VERSION}, "
grep "PRETTY_NAME" /etc/os-release 2>/dev/null | cut -d= -f2 | sed 's/"//g'
printf "* python v"; python3 --version | awk '{print $2}'
printf "* pip v"; pip --version | awk '{print $2}'
printf "* node "; node --version
# printf "* "; java -version 2>&1 | grep "version" | sed 's/version /v/g' | sed 's/"//g'
# printf "* "; go version | sed 's/version go/v/g' | cut -d" " -f1-
printf "\e[92m"
echo "───────────────────────────────────────────────────────"
printf "\e[0m"

export PATH="${HOME}/.local/bin:$PATH"

alias ll='ls -ahl'
