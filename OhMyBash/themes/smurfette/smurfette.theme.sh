#!/usr/bin/env bash
# Oh My Bash - Tema "Smurfette"

# 🎨 Definir colores
COLOR1="\\[\\e[38;2;201;158;201m\\]"
COLOR2="\\[\\e[38;5;159m\\]"
RESET="\\[\\e[0m\\]"

# 🖼️ Banner de bienvenida
clear
echo -e "\e[38;5;211m Ismael \e[0m\e[38;2;201m ♡ \e[0m\e[38;5;211m Rebeca       \e[0m\e[38;4;1mVPS:\e[0m\e[38;1;11m $(hostname)\n\e[38;5;211m --------------------------------------------- \e[0m"
                    
# 🚀 Alias útiles
alias ll='ls -lah --color=auto'
alias cls='clear'
alias bye='exit & exit'

# 🚀 Alias GIT
alias gs='git status'
alias ga='git add . && git add *'
alias gc='git commit -m'
alias gp='git pull'
alias gitConfig='git config --global user.name "La Barrufeta" && git config --global user.email labarrufetallaminadures@hotmail.com && git config --global receive.denyCurrentBranch updateInstead && git config --global init.defaultBranch master && git config --global advice.addIgnoredFile false'

# 🚀 Alias UBICACIONES
alias ~='cd ~'
alias home='cd ~'
alias externo='cd /media/externo'
alias backup='cd /media/backups'
alias backups='cd /media/backups'
alias sd='cd /storage/D16F-30BD'
alias ..='cd ..'
alias ...='cd ../..'

# 🚀 Alias VPS
alias minecraft='sh /media/Minecraft/start.sh'
alias vps='ssh root@193.24.210.230 -p 8000 -i ~/private_key.txt'

# 🚀 Alias LARAVEL
alias laravelFix='chown -R $USER:www-data storage && chown -R $USER:www-data bootstrap/cache && chmod -R 775 storage && chmod -R 775 bootstrap/cache && chown -R $USER:www-data storage/lang && chown -R $USER:www-data lang && chmod -R 775 storage/lang && chmod -R 775 lang'

# 🎭 Prompt basado en absimple
function _omb_theme_PROMPT_COMMAND() {
    ## PS1="\\[\\e[38;2;201;158;201m\\]▶\\[\\e[0m\\]\\[\\e[38;2;229;173;229m\\]\\W\\[\\e[0m\\]\\[\\e[38;2;217;169;217m\\]:\\[\\e[0m\\]\n"
    PS1="${COLOR1}\n▶ ${RESET}${COLOR1}\\w${RESET}${COLOR2}:${RESET}"
}

# Cargar el prompt en Oh My Bash
_omb_util_add_prompt_command _omb_theme_PROMPT_COMMAND
