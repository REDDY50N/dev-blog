#!/bin/bash

APT_PACKAGES="python3-pip mkdocs"
PIP_PACKAGES="mkdocs-material mkdocs-git-revision-date-plugin"

INSTALL=false
for PKG in $APT_PACKAGES; do
  STATUS="$(dpkg-query -W --showformat='${db:Status-Status}' "$PKG" 2>&1)"
  if [ ! $? = 0 ] || [ ! "$STATUS" = installed ]; then
    INSTALL=true
    break
  fi
done
if "$INSTALL"; then
  sudo apt update
  sudo apt install -y $APT_PACKAGES
fi


for PKG in $PIP_PACKAGES; do
  STATUS=$(pip list | grep $PKG)
  if [ -z "$STATUS" ]; then
    pip install $PKG
    break
  else
    echo "`pip list | grep $PKG` [installiert]"
  fi
done

apt list $APT_PACKAGES

pip install mkdocs-git-revision-date-plugin



## If methods above do not work
## Alternative ways to install required packages if not installed:

#THEME_INSTALLED=$(pip list | grep sphinx-rtd-theme)
#if [ -z "$THEME_INSTALLED" ]; then
#  pip install sphinx-rtd-theme
#else
#  echo "`pip list | grep sphinx-rtd-theme` [installiert]"
#fi

#THEME_INSTALLED=$(pip list | grep recommonmark)
#if [ -z "$THEME_INSTALLED" ]; then
#  pip install recommonmark
#else
#  echo "`pip list | grep recommonmark` [installiert]"
#fi


#REQUIRED_PKG="some-package"
#PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
#echo Checking for $REQUIRED_PKG: $PKG_OK
#if [ "" = "$PKG_OK" ]; then
#  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
#  sudo apt-get --yes install $REQUIRED_PKG
#fi


#MISSING=$(dpkg --get-selections $PACKAGES 2>&1 | grep -v 'install$' | awk '{ print $6 }')
# Optional check here to skip bothering with apt-get if $MISSING is empty
#sudo apt-get install $MISSING


#pip install sphinx-rtd-theme

#dpkg -s <pkg-name> 2>/dev/null >/dev/null || sudo apt-get -y install <pkg-name>
