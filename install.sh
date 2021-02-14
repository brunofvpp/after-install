#/bin/bash


if [[ "${UID}" -ne 0 ]]
then
  echo 'Must execute with sudo or root' >&2
  exit 1
fi

clear

echo "### Removendo pacotes"
sudo apt purge -y epiphany-browser maya-calendar pantheon-mail > /dev/null 2>&1

echo "### Update"
sudo apt-get update > /dev/null 2>&1

echo "### Upgrade & dist-upgrade"
sudo apt-get upgrade -y > /dev/null 2>&1
sudo apt-get dist-upgrade -y > /dev/null 2>&1

echo "### Instalando pacotes"

echo "     > Ensencial"
sudo apt install -y git curl virtualenv zsh python-pip software-properties-common apt-transport-https wget zip unzip unrar libutempter0 > /dev/null 2>&1

echo "     > Baixando arquivos .deb"
cd /tmp

echo "       - google-chrome"
wget -O chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -q

echo "       - gitkraken"
wget -O gitkraken.deb "https://release.axocdn.com/linux/gitkraken-amd64.deb" -q

echo "       - vs-code"
wget -O code.deb "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -q

echo "       - discord"
wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb" -q

echo "       - slack"
wget -O slack.deb "https://downloads.slack-edge.com/linux_releases/slack-desktop-4.12.2-amd64.deb" -q

echo "     > Instalando arquivos .deb"

echo "       - google-chrome"
sudo dpkg -i chrome > /dev/null 2>&1

echo "       - gitkraken"
sudo dpkg -i /tmp/gitkraken > /dev/null 2>&1

echo "       - vs-code"
sudo dpkg -i code > /dev/null 2>&1

echo "       - discord"
sudo dpkg -i discord > /dev/null 2>&1

echo "       - slack"
sudo dpkg -i slack > /dev/null 2>&1

sudo apt install -f > /dev/null 2>&1

echo "     > spotify"
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - > /dev/null 2>&1 2>&1
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null 2>&1
sudo apt update > /dev/null 2>&1
sudo apt install -y spotify-client > /dev/null 2>&1

echo "     > firefox"
sudo apt install -y firefox > /dev/null 2>&1

echo "     > vlc"
sudo apt install -y vlc > /dev/null 2>&1

echo "     > guake"
sudo apt install -y guake > /dev/null 2>&1

echo "     > sublime-text"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - > /dev/null 2>&1 2>&1
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null 2>&1
sudo apt-get update > /dev/null 2>&1
sudo apt-get install sublime-text > /dev/null 2>&1

echo "     > docker"
sudo apt-get remove docker docker-engine docker.io containerd runc > /dev/null 2>&1

echo "     > docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null 2>&1 2>&1
sudo chmod +x /usr/local/bin/docker-compose > /dev/null 2>&1
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose > /dev/null 2>&1

echo "     > oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1

echo "     > fira-code"
sudo apt install -y fonts-firacode > /dev/null 2>&1

echo "       - configurando zsh"
sed -i 's/robbyrussell/spaceship/g' ~/.zshrc
echo "SPACESHIP_CHAR_SYMBOL='❯'" >> ~/.zshrc
echo "SPACESHIP_CHAR_SUFFIX=' '" >> ~/.zshrc

echo "### Meu alias"
echo "alias u='sudo apt update'" >> ~/.zshrc
echo "alias i='sudo apt install -y'" >> ~/.zshrc
echo "alias p='sudo apt purge -y'" >> ~/.zshrc
echo "alias dp='sudo dpkg -i'" >> ~/.zshrc
echo "alias update-gitkraken='cd /tmp;wget https://release.axocdn.com/linux/gitkraken-amd64.deb && sudo apt install -y ./gitkraken-amd64.deb'" >> ~/.zshrc

echo "### Criando workspace"
mkdir ~/workspace > /dev/null 2>&1

echo "### Baixando wallpaper e profile pictures"
wget --no-check-certificate -O ~/Pictures/wallpaper-purple.png "https://docs.google.com/uc?export=download&id=1LStwFgjZn3XOW5Wv0kUg-KIz-HtaWPPy" -q
wget --no-check-certificate -O ~/Pictures/profile.png "https://docs.google.com/uc?export=download&id=1VoaWZ7swFbdQZcxq5VEH-ToHE6hHyWf8" -q
# sudo gsettings set org.gnome.desktop.background picture-uri ~/Pictures/wallpaper-purple.png

echo "### Limpando pacotes"
sudo apt autoremove -y > /dev/null 2>&1
sudo apt clean > /dev/null 2>&1

# echo "alias update-gitkraken='cd /tmp;wget https://release.axocdn.com/linux/gitkraken-amd64.deb && sudo apt install -y ./gitkraken-amd64.deb'" >> ~/.zshrc
# echo "alias sa='cd /home/$USER/workspace/siscoban-lrf;workon siscoban-lrf'" >> ~/.zshrc
# echo "alias sd='cd /home/$USER/workspace/siscoban-caravelas;workon siscoban-caravelas'" >> ~/.zshrc
# echo "alias ss='cd /home/$USER/workspace/sisbot;workon sisbot'" >> ~/.zshrc
# echo "alias r='python manage.py runserver'" >> ~/.zshrc
# echo "alias m='python manage.py makemigrations'" >> ~/.zshrc
# echo "alias mi='python manage.py migrate'" >> ~/.zshrc

# echo "5 - CRIANDO VIRTUALENVS"
# pip install --upgrade pip
# pip install virtualenvwrapper
# echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.zshrc
# echo "export PROJECT_HOME=$HOME/Devel" >> ~/.zshrc
# echo "source /home/$USER/.local/bin/virtualenvwrapper.sh" >> ~/.zshrc
# source ~/.zshrc
# mkvirtualenv --python=`which python3` siscoban-lrf
# mkvirtualenv --python=`which python3` siscoban-caravelas
# mkvirtualenv --python=`which python3` sisbot
