#!/bin/bash

#set -euo pipefail

# Reference: https://jekyllrb.com/docs/installation/ubuntu/


CONF_FILE="${HOME}/.bashrc"
SHELL_NAME=$(basename "$SHELL")
if [[ "$SHELL_NAME" = "zsh" ]]; then
  CONF_FILE="${HOME}/.zshrc"
  echo "Detected zsh shell. Using ${CONF_FILE}."
fi


function help()
{
cat << EOM
Install Jekyll and its Ruby Gem dependecies.

Usage:
  $(basename "$0") [options]

Options:
  -h, --help    Show this help message.
  --ruby        Installs ruby (run as root user).
  --jekyll      Install Jekyll (run as non-root user).
EOM
}

function install_ruby {
  sudo apt install -y ruby-full build-essential zlib1g-dev
}

function install_jekyll {
  if [ $(id -u) == 0 ]; then
    echo "Please run this script as a non-root user."
    exit 1
  fi
  echo '# Install Ruby Gems to ~/gems' >> ${CONF_FILE} && \
  echo 'export GEM_HOME="$HOME/gems"' >> ${CONF_FILE} && \
  echo 'export PATH="$HOME/gems/bin:$PATH"' >> ${CONF_FILE} && \
  source ${CONF_FILE}
  gem install jekyll bundler && source ${CONF_FILE}
}


while [[ $# -gt 0 ]]; do
    argument="$1"

    case $argument in
        -h | --help)
            help
            exit 0
        ;;

        --ruby)
            install_ruby
            shift
        ;;

        --jekyll)
           install_jekyll
            shift
        ;;

        *)
          echo "Unknown option: $1"
          help
          exit 1
          ;;
    esac
done