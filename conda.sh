#!/bin/bash
user_name=$(whoami)
if [ "${user_name}" == "root" ]
then
	echo "This must not be run as root!"
	exit
fi
echo -e "Remember 3 things:\n1. Do not run this as root\n2. Say yes to conda options\nClose your terminal after the program run"
echo -e "Proceed?"
read green_light
if [ "${green_light}" == "Y" ] || [ "${green_light}" == "y" ]
then
	echo "Have fun!"
elif [ "${green_light}" == "N" ] || [ "${green_light}" == "n" ]
then
	echo "Bye!"
	exit
else
	echo "Not a valid answer!"
	exit
fi
cd $HOME
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
echo "PATH=\$PATH:\$HOME/bin" >> .bashrc
echo "export PATH" >> .bashrc
