#!/bin/bash

readonly ADDRESS=http://127.0.0.1:8000/

pkill -e -f mkdocs && echo "INFO: Last server instance stopped first."

mkdocs build && echo "INFO: Building the docs was successful" || "ERROR: Failed to build the docs!"

echo "INFO: Starting mkdoc server. Open in webbrowser: ${ADDRESS}"
mkdocs serve & python3 -mwebbrowser ${ADDRESS}

