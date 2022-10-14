#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.
#

export HOME=/config
whoami

#npm install
exec node server.js
