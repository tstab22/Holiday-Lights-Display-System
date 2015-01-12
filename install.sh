#!/bin/bash
# @author Henry Schmale
# @date January 11, 2015
# @file install.sh
# installs the Holiday Lights System and performs default config on it

# -- Global Variables --
# project name
project="Holiday-Lights-Display-System"
# executable name
exe="HolidayLights"
# config file name
cfgFile="cfg.ini"
# song resources folder
songResDir=~/$project/resources/songs
# db File name
dbFile="lights.db"

#declare functions
# builds the program and moves it to it's working directory
function BuildMv
{
	# make/build the program
	make
	
	# move to the install directory
	mkdir ~/$project
	mv ./$exe ~/$project
	
	# copy necessay scripts to prog directory
	cp ./updateDB.sh ~/$project/	#database update script
}

# set up the prgm's working directory
function SetUpDir
{
	cd ~/$project	# change to working directory
	mkdir resources
	cd resources
	mkdir songs 	# this directory holds the song data
	cd ..			# return from the resources directory
}

# generate the config file
function makeConfigFile
{
	cd ~/$project
	echo "; Config File for Holiday Lights System" >> $cfgFile
	echo "; Generated by the bash script" >> $cfgFile
}

#database configurator
# configures the database
function dbCfg
{
	./$exe --createDB # create the database file
	cd ~/$project	# return to primary directoryc 
	# copy/move the selected files to the songs resource folder
	for file in $( ls ~/Music/ ) ; do
		if [ -e ~/Music/$file ]; then #check file existance
			cp ~/Music/$file $songResDir
		fi
	done
	# begin conversion
	cd ~/$project/resources/songs
	for f in $( ls ) ; do
		ffmpeg -i $f $f.wav
	done
	rm -r *.mp3 # remove incompatible files
	# add to database
	cd ~/$project
	for f in $( ls resources/songs ) ; do
		inst="Insert into MEDIA(name, path) values('$f', 'resources/songs/$f');"
		sqlite3 $dbFile "$inst"
	done
}

# Main Bash script
BuildMv
echo "Finished Building The Program"
SetUpDir
echo "Finished Creating files"
#makeConfigFile
echo "Begining Database configuration"
dbCfg

