#!/bin/bash
#Website Malware Audit

#Download database
if [ "$(stat -c%Y "${HOME}/ShellDatabase")" -lt "$(date +%s --date='12 hours ago')" ]; then
    latestDB=1
elif [ ! -s "${HOME}/ShellDatabase" ]; then
    latestDB=1
fi
if [ "${latestDB}" -eq 1 ]
then
	echo "Downloading database..."
	wget -q -O "${HOME}/ShellDatabase" https://raw.githubusercontent.com/javaj0hn/shell-scanner/master/ShellDatabase
	touch "${HOME}/ShellDatabase"
fi

#Begin scanning for shells/injections
echo "\nScanning for malicious shells & injections..."
echo "===================================="
while read p; do
    grep -r "$p"
done <"${HOME}/ShellDatabase"
echo "====================================\n"

#Begin scanning for cryptophp ~ https://foxitsecurity.files.wordpress.com/2014/11/cryptophp-whitepaper-foxsrt-v4.pdf
echo "\nScanning for CryptoPHP..."
echo "===================================="
find . -type f -iname "social*.png" -exec grep -E -o 'php.{0,80}' {} \; -print
echo "====================================\n"

#Begin scanning for recently altered files
echo "\nScanning for recently altered files..."
echo "===================================="
find -ctime -10 ! -perm 000 -ls
echo "====================================\n"
