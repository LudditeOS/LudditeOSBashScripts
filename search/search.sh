#in das LudditeRoot Verzeichnis kopieren

sudo find /home/oliver/LudditeOS/ -iname '*'$1'*' > ${1}results.txt


sudo egrep  -I -n -H -ir '*'$1'*' --exclude-dir=out /home/oliver/LudditeOS >> ${1}results.txt