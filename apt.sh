wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | sudo apt-key add -
rm dotdeb.gpg
cp ./apt/* /etc/apt/ -r
apt-get update
