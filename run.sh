#!/bin/bash

readonly ADDRESS=http://127.0.0.1:4000/

pkill -e -f jekyll && echo "INFO: Last server instance stopped first."

echo "INFO: Starting Jekyll server. Open in webbrowser: ${ADDRESS}"
cd dev-blog && jekyll serve &
python3 -mwebbrowser ${ADDRESS}

