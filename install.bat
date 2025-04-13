@echo off

:start
cls

set python_ver=39

python ./get-pip.py

cd \
cd \python%python_ver%\Scripts\
pip install mkdocs 
pip install mkdocs-material
pip install mkdocs-git-revision-date-plugin
pause
exit