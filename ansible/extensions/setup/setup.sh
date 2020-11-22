#!/bin/bash

set -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
ROOT_DIR=$(cd "$DIR/../../" && pwd)

PYTHON_REQUIREMNTS_FILE="$DIR/python_requirements.txt"

#Touch vpass
echo "Touching vpass"
if [ -w "$ROOT_DIR" ]
then
   touch "$ROOT_DIR/.vpass"
else
  sudo touch "$ROOT_DIR/.vpass"
fi



echo " "
echo " "
echo "To complete this installation you must install pip dependencies manually based on your existing python environment setup"
echo "If you are not using a virtual environment, you might have to use sudo"
echo "pip install --no-cache-dir  --upgrade --requirement "$PYTHON_REQUIREMNTS_FILE

echo " "
echo "PROTIP: If you are using a python virtual environment then you can just copy paste and run the above command"


exit 0