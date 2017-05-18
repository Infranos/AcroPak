#!/bin/bash

sudo updatedb #To make the user aware the install requires sudo, plus lets us use locate

CHECKER=/tmp/check.txt

locate AcroPak | grep AcroPak$ > $CHECKER

if [ ! -s $CHECKER ]; then
	locate AcroPak | grep AcroPak-master$ > $CHECKER
	if [ ! -s $CHECKER ]; then
		echo Error, installation folder not found.
		echo Please place the AcroPak folder onto your system.
		exit -1
	fi
fi

FOLDER=`cat $CHECKER`

if [ ! -s $FOLDER/acro ]; then
	echo Error, acro file not found.
	echo Consider redownloading either the acro file or its respective folder.
	exit -1
else
	chmod +x $FOLDER/acro
	sudo cp $FOLDER/acro /usr/bin/acro
	if [ -s /usr/bin/nym ]; then
		sudo rm /usr/bin/nym
        fi
	sudo ln /usr/bin/acro /usr/bin/nym
	echo Installation complete!
fi
