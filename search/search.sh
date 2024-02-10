#in das LudditeRoot Verzeichnis kopieren

sudo find /home/oliver/LudditeOS/ -iname '*'$1'*' > results.txt


sudo egrep -ir '*'$1'*' --exclude-dir=out /home/oliver/LudditeOS >> results.txt
