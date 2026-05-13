pyinstaller --help
pyi-archive_viewer --help
pyi-bindepend --help
pyi-makespec --help
pyi-grab_version --help
pyi-set_version --help

pip check

pyinstaller -n hello hello.py

dir dist\hello
dist\hello\hello.exe
if errorlevel 1 exit 1
