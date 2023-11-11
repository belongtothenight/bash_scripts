apt-get update
apt-get upgrade -y
apt-get install -y gcc make cmake doxygen

#Ref: https://github.com/jothepro/doxygen-awesome-css
git clone git@github.com:jothepro/doxygen-awesome-css.git
cd doxygen-awesome-css
make install

echo "doxygen-awesome-css files installed to /usr/local/share/"
