#!/bin/sh
preinstall=(zsh delta neovim git starship nodejs)
wgets="wget -q --show-progress"
for i in ${preinstall[@]}
do 
    echo -e "\033[32mInstalling $i\033[0m"
    case $i in
        zsh)
            if [ ! `which zsh` ];then
                sudo apt install zsh wget git curl -y
            fi
            ;;
        delta)
            if [ ! `which delta` ];then
                $wgets https://github.91chi.fun//https://github.com//dandavison/delta/releases/download/0.10.3/git-delta-musl_0.10.3_amd64.deb
		sudo dpkg -i git-delta-musl_0.10.3_amd64.deb
                rm git-delta-musl_0.10.3_amd64.deb 
            fi
            ;;
        neovim)
            if [ ! `which nvim` ];then
                cd /usr/local/bin
                sudo $wgets https://github.com/neovim/neovim/releases/latest/download/nvim.appimage 
                sudo chmod +x ./nvim.appimage
                sudo ./nvim.appimage --appimage-extract
                sudo ln -s /usr/local/bin/squashfs-root/usr/bin/nvim /usr/local/bin/nvim
                cd
            fi
            ;;
        git)
            gitver=`git --version | awk '{print $3}'`
            if [ ! `which git` ] || [ $gitver != "2.34.0" ];then
                sudo apt update \
                && sudo apt -y install dh-autoreconf libcurl4-gnutls-dev libexpat1-dev make gettext libz-dev libssl-dev libghc-zlib-dev \
                && wget -c https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.34.0.tar.gz -O - | sudo tar -xz -C /usr/src \
                && cd /usr/src/git-* \
                && sudo make prefix=/usr/local all \
                && sudo make prefix=/usr/local install \
                && sudo apt -y remove git
            fi
            ;;
        starship)
            if [ ! `which starship` ];then
                $wgets https://github.com/starship/starship/releases/latest/download/starship-x86_64-unknown-linux-musl.tar.gz
                tar xf starship-x86_64-unknown-linux-musl.tar.gz
                sudo mv starship /usr/local/bin/
                rm starship-x86_64-unknown-linux-musl.tar.gz
            fi
            ;;
        zinit)
            if [ ! `which zinit` ];then
                mkdir -p "$HOME/.zinit" && chmod g-rwX "$HOME/.zinit"
                git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin"
            fi
            ;;
        *)
            echo "$i had installed!"
    esac
done
