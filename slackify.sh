#!/bin/bash
config=$1

# Function to deal with packages
function config_apt {
  # Get packages from config
  apt=`cat $config | jq '.apt'| grep -ve \\\[ -ve \\\] | sed 's/,//g' | sed 's/"//g'`
  # Install packages 
  apt-get install -o Dpkg::Options::="--force-confold" --force-yes -y $apt
}

# Function to deal with files
function config_file {
  # Get file attributes from config
  filesource=`cat $config | jq '.file.source' | sed 's/"//g'`
  filedest=`cat $config | jq '.file.dest' | sed 's/"//g'`
  fileuser=`cat $config | jq '.file.user' | sed 's/"//g'`
  filegroup=`cat $config | jq '.file.group' | sed 's/"//g'`
  fileperms=`cat $config | jq '.file.perms' | sed 's/"//g'`
  # Check for existing user and group  before adding to keep console cleam
  if ! genent passwd $fileuser > /dev/null 2>&1
  then
    useradd $fileuser 2>/dev/null
  fi
  if ! getent group $filegroup > /dev/null 2>&1
  then
    groupadd $filegroup >/dev/null
  fi
  # Check if file has changed
  if ! cmp -s $filesource $filedest
  then
    # Deploy file
    cp ${filesource} ${filedest}
    # Set file owner
    chown $fileuser:$filegroup $filedest
    # Set file permissions
    chmod $fileperms $filedest
    # Restart service as file has changed
    config_service
  fi
}

# Function to deal with service
function config_service {
  # Get service from config
  service=`cat $config | jq '.service' | sed 's/"//g'`
  # Restart service
  service $service restart
}

config_apt
config_file
