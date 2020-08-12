#!/bin/bash

ANACONDA_INSTALL=0

#Ask if Anaconda must be installed
while true; do
    read -p "Do you wish to install Miniconda?" yn
    case $yn in
        [Yy]* ) ANACONDA_INSTALL=1; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

#Download and install Miniconda for virtual enviroment creation 
if [[ "ANACONDA_INSTALL" -eq 1  ]]; then
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && sh Miniconda3-latest-Linux-x86_64.sh 
	rm -f Miniconda* && source ~/.bashrc
fi
echo "Miniconda was installed in ~/miniconda3 directory"

#Create iqtree enviroment
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
