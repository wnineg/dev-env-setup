path+=(
"$HOME/.local/bin"
'/home/wwong/java/bin'
)
export path
export EDITOR=nvim
export PAGER=less
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export LESS='-F -n'
export JAVA_HOME='/home/wwong/java'
export KUBECONFIG=~/.kube/config

# For WSL
if [[ $WSL_DISTRO_NAME ]]; then
    path+=('/mnt/c/Windows' '/mnt/c/Windows/System32')
    if [[ $TERM_PROGRAM == WezTerm ]]; then
        path+=('/mnt/c/Program Files/WezTerm')
    fi
    export whost="$(ip route show | grep -i default | awk '{print $3}')"
fi
. "$HOME/.cargo/env"
