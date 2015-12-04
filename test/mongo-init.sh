#!/usr/bin/env bash
#
# @author: Brandon Crooks
# @version: v1.0
# @description: Create and start a mongo database. Mongo-init will create a
# default database if one does not exist.
#

# TODO:
# - Check if mongo folder exists
# - [Yes]
#  - Start server
# - [No]
#  - Create dir folder/db
#  - chnage folder permissions
#  - Start Server
# - Add debug log
#  - Push errors to log

declare MONGO_DIR="${PWD}/data/db"

function createMongoDir() {
  mkdir -p ${MONGO_DIR}
  chmod u+x ${MONGO_DIR}
}

function checkInstallation() {
  # check if mongo is installed
  declare -a program=("mongo" "mongod")

  for i in "${program[@]}"; do
    declare result="$(which "${i}")"
    if [[ -z "${result}" ]]; then
      echo "Oops… Looks like ${$i} is not installed on this machine."
      echo "run `$ brew install moongo` "
      exit 1
    else
      # log to debug array
      # echo "${program} is installed"
      echo ""
    fi
  done
}

function startMongoServer() {
  checkInstallation
  echo "Starting mongo server…"
  mongod --dbpath "${PWD}/data/"
}

if [[ -d "${MONGO_DIR}" ]]; then
  echo "Folder exists"
  startMongoServer
else
  echo "Creating mongo directory"
  createMongoDir
  startMongoServer
fi

exit 0
