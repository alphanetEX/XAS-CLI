#!/bin/bash
#Developer:AlphanetEX
passwx=""
read -p "writte your password: " passwx
passw= echo -e "$passwx\n"

$passw | sudo -S apt-get update
$passw | sudo -S apt-get upgrade -y -f
$passw | sudo -S apt-get install vim -y
$passw | sudo -S apt-get install trickle #network velocity limit
$passw | sudo -S apt-get install tig -y
$passw | sudo -S apt-get install etckeeper -y
#configure timezone to asignate correct time in your server and evit change modification of time
#$passw | sudo -S timedatectl list-timezones
$passw | sudo -S timedatectl set-timezone "America/Argentina/Buenos_Aires"
$passw | sudo -S apt-get install ntpdate
$passw | sudo -S ntpdate-debian

$pass | sudo -S etckeeper init
$pass | sudo -S etckeeper commit -m "Initial checkin"

#basic configuration with vim
touch ~/.vimrc
cat <<EOM >> ~/.vimrc
set showmode
set autoindent
set tabstop=4
set expandtab
syntax on
EOM

#ssh configuration
$passw | sudo -S sed -i '13c\Port 22' /etc/ssh/sshd_config
$passw | sudo -S sed -i '31,38d' /etc/ssh/sshd_config
$passw | sudo -S sed -i '/Expect / i #LoginGraceTime 2m \
PermitRootLogin no \
StrictModes yes \
MaxAuthTries 3 \
MaxSessions 3 \
PasswordAuthentication no \
PubkeyAuthentication yes' /etc/ssh/sshd_config
$passw | sudo -S /etc/init.d/ssh restart

#fail2ban configuration
$passw | sudo -S apt-get install fail2ban -y
$passw | sudo -S cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
$passw | sudo -S sed -i '63c\bantime  = 5m' /etc/fail2ban/jail.local
$passw | sudo -S sed -i '67c\findtime  = 5m' /etc/fail2ban/jail.local
$passw | sudo -S sed -i '70c\maxretry  = 3' /etc/fail2ban/jail.local
$passw | sudo -S sed -i '244,246d' /etc/fail2ban/jail.local
$passw | sudo -S sed -i '244c\enabled = true' /etc/fail2ban/jail.local
$passw | sudo -S sed -i '245c\port    = 22' /etc/fail2ban/jail.local
$passw | sudo -S sed -i '246c\logpath = %(sshd_log)s' /etc/fail2ban/jail.local
$passw | sudo -S sed -i '247c\backend = %(sshd_backend)' /etc/fail2ban/jail.local
$passw | sudo -S /etc/init.d/fail2ban restart
$pass | sudo -S etckeeper commit "Basic Security Completed"

#github configuration
git config --global user.mail "fixtexhax@gmail.com"
git config --global user.name "AlphanetEX"
#generating ssh keys
echo "\n" | ssh-keygen -t rsa -b 4096 -C "fixtexhax@gmail.com" -P "vkpetkqnc"
#-C email asignation
#-P password asignation
$passw | sudo -S etckeeper commit "Git Github/Gitlab basic enviroment completed"

#configuracion de nvm y npm de comanderia
$passw | sudo -S apt-get install -y curl build-essential libssl-dev git
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
cat <<EOM >> .bashrc

nvm ls-remote
nvm install v10.15.3
comandx=$(npm -v)
if [[ $comandx == 6.4.1 ]]; then
echo "installation success!"
sed -i '123,131d' .bashrc
else
echo "ERROR!"
fi
EOM
$passw | sudo -S sed -i '125c\comandx=$(npm -v)' ~/.bashrc
$passw | sudo -S sed -i '126c\if [[ $comandx == 6.4.1 ]]; then' ~/.bashrc
$passw | sudo -S etckeeper commit "nvm with node and npm dependencias installed"

#configurating docker instalation
$passw | sudo -S apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

#x64 and  x86 distribution
$passw | sudo -S add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#arm32v7 distribution
#sudo add-apt-repository \
  # "deb [arch=armhf] https://download.docker.com/linux/ubuntu \
  # $(lsb_release -cs) \
  # stable"

$passw | sudo -S apt-get install docker-ce docker-ce-cli containerd.io -y
$passw | sudo -S groupadd docker
$passw | sudo -S usermod -aG docker $USER
$passw | sudo -S etckeeper commit "Docker installation was succesfull"

#odroid shifter shell instalation 
$passw | sudo -S apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
git clone https://github.com/hardkernel/wiringPi
cd wiringPi/
./build

$passw | sudo -S etckeeper commit "WiringPI and Shifter Shield configuration was success"

$passw | sudo -S apt-get install ccze -A
#dmesg | ccze -A 

#-------------aws ec2 terminal customization installation------------------------
$passw | sudo -S apt-get install vim-nox git python-pip -y
$passw | sudo -S pip install powerline-status
$passw | sudo -S apt-get install powerline -y
$passw | pip install --user git+git://github.com/powerline/powerline
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf 
wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf 
$passw | sudo -S mv PowerlineSymbols.otf /usr/share/fonts/
$passw sudo -S mv 10-powerline-symbols.conf /etc/fonts/conf.d/
cd /usr/share/fonts | fc-cache -fv
cd ~/


touch ~/.vimrc
cat <<EOF >> ~/.vimrc

set rtp+=.local/lib/python2.7/site-packages/powerline/bindings/vim/
" Always show statusline 
set laststatus=2  
" Use 256 colours (Use this setting only if your terminal supports 256 colours) 
set t_Co=256
EOF


cat <<EOF >> ~/.bashrc

if [ -f .local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; 
then source .local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh  
fi
EOF

#---------------ohmyzsh-configuration---------------------------------

$passw | sudo -S apt-get install zsh -y 
$passw | sudo -S apt-get install fish -y 

cat <<EOF >> ~/.bashrc
# Launch Zsh
if [ -t 1 ]; then
exec zsh
fi
EOF

$passw | sudo -S sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

newline='ZSH_THEME="agnoster"'

sed -i "11s/.*/$newline/" .zshrc 
echo "restart your terminal!"

#-------------powerlevel 9k mode  check :------------------------------------

$passw | sudo -S git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
sudo cp Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf /usr/share/fonts/
cd /usr/share/fonts
fc-cache -fv
cd ~/

#building awesome terminal fonts 
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git
cd awesome-terminal-fonts
./build
cd ..
$passw | sudo -S cp -r  build/* /usr/share/fonts/
cd /usr/share/fonts/
fc-cache -fv
cd 


#newline='ZSH_THEME="powerlevel9k/powerlevel9k"'  
powerlevel9k='POWERLEVEL9K_MODE="nerdfont-complete"' 
sed -i '11c\ZSH_THEME="powerlevel9k/powerlevel9k"' ~/.zshrc
sed -i -e "12s/.*/$powerlevel9k/" ~/.zshrc

sed -i '/User configuration/ i source ~/.oh-my-zsh/custom/themes/powerlevel9k/powerlevel9k.zsh-theme \
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1 \
POWERLEVEL9K_SHORTEN_DELIMITER="" \
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right" \
POWERLEVEL9K_PROMPT_ON_NEWLINE=true \
#espacios entre inconos a la izquierda \
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="" \
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="" \
POWERLEVEL9K_WHITESPACE_BETWEEN_LEFT_SEGMENTS=" " \
#espacios entre iconos a la derecha \
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="" \
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=" " \
POWERLEVEL9K_WHITESPACE_BETWEEN_RIGHT_SEGMENTS="" #espacios a la derecha icono\
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon disk_usage ram root_indicator dir dir_writable_joined) \
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs time_joined node_version) \
#color de configuracion de git \
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear" \
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear" \
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow" \
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow" \
#os icon background \
POWERLEVEL9K_OS_ICON_BACKGROUND="clear" \
POWERLEVEL9K_OS_ICON_FOREGROUND="015" \
#dir \
POWERLEVEL9K_SHORTEN_DELIMITER=".." \
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2 \
#Disk usage \
POWERLEVEL9K_DISK_USAGE_NORMAL_BACKGROUND="clear" \
POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND="121" \
POWERLEVEL9K_DISK_USAGE_WARNING_BACKGROUND="clear" \
POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND="202" \
POWERLEVEL9K_DISK_USAGE_CRITICAL_BACKGROUND="clear" \
POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND="196" \
#RAM colors \
POWERLEVEL9K_RAM_BACKGROUND="clear" \
POWERLEVEL9K_RAM_FOREGROUND="yellow" \
#node version color \
POWERLEVEL9K_NODE_VERSION_BACKGROUND="clear" \
POWERLEVEL9K_NODE_VERSION_FOREGROUND="green" \
#home and dir colors \
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear" \
POWERLEVEL9K_DIR_HOME_FOREGROUND="blue" \
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear" \
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="blue" \
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear" \
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red" \
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear" \
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white" \
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red" \
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"\
#status color \
POWERLEVEL9K_STATUS_OK_BACKGROUND="clear" \
POWERLEVEL9K_STATUS_OK_FOREGROUND="blue" \
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear" \
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red" \
#time color \ 
POWERLEVEL9K_TIME_BACKGROUND="clear" \
POWERLEVEL9K_TIME_FOREGROUND="whitte" \
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="clear" \
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="magenta" \
POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="clear" \
POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="green" \
# RIGHT_PROMPT Github \
# ===========================================================\
# vcs branch of git conffiguration \
#POWERLEVEL9K_SHOW_CHANGESET=true \
#POWERLEVEL9K_CHANGESET_HASH_LENGTH=6 \
#showing efects of change status git \
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="none" \
POWERLEVEL9K_VCS_CLEAN_FOREGROUND="076" \
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="none" \
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="005" \
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="none" \
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="003" \
#showing efects of github \
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind git-stash git-remotebranch git-tagname)' .zshrc
cat <<EOF >> ~/.zshrc 
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%F{white}"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%F{white} "
EOF
#--------rutas-------
#/usr/lib/python2.7/dist-packages/powerline
#.local/lib/python2.7/site-packages/powerline/


#verificacion de espacios/ pasar el codigo de sed al repo de auth01_alpha.sh