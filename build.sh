#!/bin/bash
WORKDIR=$PWD
TARGET_DIR=code

# Parse zip file name
if [[ "$1" == *.zip ]];
then
    FILENAME="$1"
else
    FILENAME="$1.zip"
fi

# install package requirements
if [ ! -f "$TARGET_DIR/requirements.txt" ];
then
    if [ -e "$TARGET_DIR/Pipfile" ];
    then
        # install pipenv
        cd $TARGET_DIR
        pip install pipenv
        pipenv lock -r > requirements.txt
        cd ..
    else
        echo "Error! Missing file(s): requirements.txt | Pipfile"
        exit 1
    fi
fi

# Create temporary directory to store the installed dependencies
mkdir -p /tmp/output
pip install -r $TARGET_DIR/requirements.txt --no-deps -t /tmp/output

# copy the source code to the temporary directory
cp -r $TARGET_DIR/* /tmp/output/

# remove cache dirs (if any)
find /tmp/output/ -name '__pycache__' -exec rm -rf {} \;

# zip contents
cd /tmp/output && zip -r $WORKDIR/$FILENAME . && cd $WORKDIR