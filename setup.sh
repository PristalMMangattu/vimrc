#!/bin/bash
REPORT_FILE=report.txt
TEMP_DIR=tmp
mkdir -p ~/${TEMP_DIR}
pushd ~/${TEMP_DIR}
TEMP_PATH=`pwd`
popd

INSTALL_SUCCESS=()
INSTALL_FAILED=()

clone_vimwiki() {
	git clone git@github.com:PristalMMangattu/vimwiki.gitgit@github.com:PristalMMangattu/vimwiki.git

	if [[ $? != 0 ]]; then
		echo "Not able to clone vimwiki, public key may not be added properly"
	fi
}

setup_git_repo() {
	# generate public key
	ssh-keygen -t ed25519 -C "pristalmangattu@gmail.com"
	echo "Public key generated in dir : ~/.ssh, please add to github and type 'yes' to continue"
	read RESPONSE

	while true
	do
		if [[ ${RESPONSE} = "yes" ]]; then
			break
		else
			echo "Public key generated in dir : ~/.ssh, please add to github and type 'yes' to continue"
			read RESPONSE
		fi
	done

	# clone vimwiki
	eval `ssh-agent`
	ssh-add
}

install_fzf() {
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

install_using_apt() {
	if [ $# -gt 1 ]; then
		sudo apt install $1
		if [ $? != 0 ]; then
			INSTALL_FAILED+=($1)
		else
			INSTALL_SUCCESS+=($1)
		fi
	fi
}

download_deb_package() {

}

install_deb_package() {

}

# vim configurations
configure_vim() {
	# installing vim-plug (plugin manager for nvim/vim)
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

	mkdir -p ~/.config/nvim/
	cp .vimrc ~/.config/nvim/init.vim

	nvim -c 'PlugInstall'
}


install_python_packages() {
pip install numpy
pip install pandas
pip install statsmodels
pip install scipy
pip install scikit-learn
pip install keras
pip install tensorflow
pip install torch

# Ploting libraries
pip install matplotlib
pip install seaborn
pip install plotly
}

# caps lock configuration
configure_capslock_key() {

}

configure() {
	configure_vim

}

sudo apt-get update
sudo apt-get upgrade

#set up bashrc
cat .bashrc >> ~/.bashrc

#set up tmux
cp .tmux.conf ~/

# install essential softwares
sudo apt install git
sudo apt install docker
sudo apt install neovim
sudo apt install exuberant-ctags
sudo apt install tmux
sudo apt-get install build-essential
sudo apt install clang
sudo apt-get install silversearcher-ag
sudo apt install lsb-core

# required for display settings.
sudo apt install gnome-control-center


DIFFMERGE_VER=4.2.0.697
echo Diffmerge published at : https://sourcegear.com/diffmerge/downloads.html
echo Which version of diffmerge should get installed \(eg, 4.2.0.697\) ?
read DIFFMERGE_VER
wget https://download.sourcegear.com/DiffMerge/4.2.0/diffmerge_${DIFFMERGE_VER}.stable_amd64.deb -P ${TEMP_PATH}

if [[ $? == 0 ]]; then
	pushd ${TEMP_PATH}
	dpkg -i diffmerge_${DIFFMERGE_VER}.stable_amd64.deb
	popd
fi

sudo reboot
