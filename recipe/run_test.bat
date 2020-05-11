pyinstaller -n hello hello.py
dir dist\hello
dist\hello\hello.exe
if errorlevel 1 exit 1

pyinstaller -n multiprocessing_test multiprocessing_test.py
dir dist\multiprocessing_test
dist\multiprocessing_test\multiprocessing_test.exe
if errorlevel 1 exit 1
