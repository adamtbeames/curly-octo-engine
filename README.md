# Slackify
Slackify is a basic tool for deploying files and packages defined in a json config file.  
**Please run bootstrap.sh prior to using this tool**

## Method of operation
1) Create json config file detailing file, packages, and service for deployment  
2) Put file for deployment in file directory  
3) Run slackify.sh and specify the config file  

## Architecture
**slackify.sh**  
Main executable script.  Expects a config file to be parsed at run time  
e.g. "./slackify.sh config/website.json"

**config/***  
Location of json config files
- "file" object contains file locations and permissions
- "apt" array contains package names
- "service" contains service name

**files/***  
Files for deployment go in this directory
