#in das LudditeRoot Verzeichnis kopieren

find /home/oliver/LudditeOS/ -iname '*'$1'*' > results.txt


egrep -ir '*'$1'*' /home/oliver/LudditeOS >> results.txt
