#!/bin/bash

if [ -z "$BIOSTAR_SRC" ]; then
	# BIOSTAR_SRC not found, will be set relative to the current directory
	export BIOSTAR_SRC=`dirname $0`
	export BIOSTAR_HOME="$BIOSTAR_SRC/home"
fi

if [ -z "$BIOSTAR_HOSTNAME" ]; then
	# BIOSTAR_HOSTNAME not found setting it automatically
	export BIOSTAR_HOSTNAME="0.0.0.0:8080"
fi

if [ -z "$DJANGO_SETTINGS_MODULE" ]; then
	# DJANGO_SETTINGS_MODULE not found setting it automatically
	export DJANGO_SETTINGS_MODULE=biostar_settings
fi

# the DJANGO_SETTINGS_MODULE needs to be in the python import path
export PYTHONPATH=$PYTHONPATH:$BIOSTAR_HOME

# setting up the python
export PYTHON_EXE=python
export DJANGO_ADMIN=biostar/manage.py

echo "*** BIOSTAR_HOME=$BIOSTAR_HOME"
echo "*** BIOSTAR_HOSTNAME=$BIOSTAR_HOSTNAME"
echo "*** DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE"

if [ $# == 0 ]; then
	echo ''
	echo Usage:
	echo '  $ biostar.sh <command>'
	echo ''
	echo 'Multiple commands may be used in the same line:'
	echo '  $ biostar.sh init test run'
	echo ''
	echo 'Commands:'
	echo '  init - initializes the database'
	echo '  test - runs all tests'
	echo '  populate -populates the system with test data'
	echo '  delete - removes everything from BioStar'
	echo '  run - runs server'
fi

while (( "$#" )); do

	if [ "$1" = "delete" ]; then
		echo '*** Deleting all data'
		# list all commands that need to be run
		cmds[0]="rm -f $BIOSTAR_HOME/db/biostar.db"

		for cmd in "${cmds[@]}"
			do
				echo $cmd
				`$cmd`
			done
	fi

	if [ "$1" = "init" ]; then
		echo "*** Initializing server on $BIOSTAR_HOSTNAME"
		$PYTHON_EXE $DJANGO_ADMIN syncdb --noinput --settings=$DJANGO_SETTINGS_MODULE
	fi

	if [ "$1" = "populate" ]; then
		echo "*** Populating server on $BIOSTAR_HOSTNAME"
		$PYTHON_EXE home/import/migrate.py home/import/datadump
	fi

	if [ "$1" = "run" ]; then
		echo "*** Running the webserver on $BIOSTAR_HOSTNAME"
		$PYTHON_EXE $DJANGO_ADMIN runserver $BIOSTAR_HOSTNAME --settings=$DJANGO_SETTINGS_MODULE
	fi

	if [ "$1" = "test" ]; then
		echo "*** Running the tests"
	fi

shift
done