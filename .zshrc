## proxy
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
# hostip=192.168.1.85
port=7890
export all_proxy="http://${hostip}:${port}"
git config --global http.proxy  http://${hostip}:${port}
git config --global https.proxy  https://${hostip}:${port}

### Added by Zinit's installer
if [ ! -f $HOME/.zinit/bin/zinit.zsh ]; then
   command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
   command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin"
fi

source $HOME/.zinit/bin/zinit.zsh

### End of Zinit's installer chunk
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
bindkey ',' autosuggest-accept
eval "$(starship init zsh)"

[[ ! -f ~/.aliases ]] || source ~/.aliases
[[ ! -f ~/.100ask ]] || source ~/.100ask
[[ ! -f ~/.config/bindkey.zsh ]] || source ~/.config/bindkey.zsh
[[ ! -f ~/.config/functions ]] || source ~/.config/functions

if [ -x /usr/bin/dircolors ];then
   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# 忽略大小写补全
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# settingsPATH
# PATH_WIN=/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/d/Scoop/apps/typora/0.10.11:/mnt/d/Scoop/apps/notepadplusplus/7.9.5
# PATH_WIN2=/mnt/d/Scoop/apps/typora/current
# PATH_LINUX=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.zinit/polaris/bin
# PATH=$PATH_LINUX:$PATH_WIN:$PATH_WIN2
#export PATH=$PATH:/mnt/c/Scoop/apps/beyondcompare_echoiron/current

