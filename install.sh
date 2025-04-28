#!/bin/bash

DISTRO=$(grep ^ID= /etc/os-release | cut -d= -f2 | tr -d '"')

install_ubuntu() {
    echo "Ubuntu"
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y zsh curl git alacritty
}

install_fedora() {
    echo "Fedora"
    sudo dnf update -y
    sudo dnf install -y zsh curl git alacritty
}

if [[ "$DISTRO" == "ubuntu" ]] || [[ "$DISTRO" == "debian" ]]; then
    install_ubuntu
elif [[ "$DISTRO" == "fedora" ]]; then
    install_fedora
else
    echo "Distro not supported"
    exit 1
fi

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

chsh -s $(which zsh)

mkdir -p ~/.oh-my-zsh/custom/themes

cp ~/.dotfiles/zsh/.zshrc ~/.zshrc

cp ~/.dotfiles/oh-my-zsh/custom/themes/lt.zsh-theme ~/.oh-my-zsh/custom/themes/lt.zsh-theme

sed -i 's/ZSH_THEME=".*"/ZSH_THEME="lt"/' ~/.zshrc
