#in das LudditeRoot Verzeichnis kopieren

#sudo find /home/oliver/LudditeOS/ -iname '*'$1'*' > ${1}results.txt


sudo egrep -I -n -H -ir --exclude-dir=out --exclude='*.java' --exclude='*.html' --exclude='*/test/*' '*'$1'*' /home/oliver/LudditeOS >> ${1}results.txt
