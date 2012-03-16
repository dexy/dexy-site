# stuff in here is also in create-custom-ami and will be removed from here when
# a new custom image is built that has these installs already

echo "PATH=$PATH:/var/lib/gems/1.8/bin:/usr/games:/usr/local/texlive/2011/bin/x86_64-linux" | sudo tee -a /etc/environment
echo "HOME=/home/ubuntu # for erlang" >> /home/ubuntu/.pam_environment

sudo apt-get install -y build-essential
sudo apt-get install -y ttf-freefont
sudo apt-get install -y libv8-dev

sudo pip install BeautifulSoup
sudo pip install cssutils
sudo pip install pynliner
sudo pip install ansi2html

wget http://nodejs.org/dist/v0.6.12/node-v0.6.12.tar.gz
tar -xzf node-v0.6.12.tar.gz
cd node-v0.6.12/
./configure
make
sudo make install
cd ..

wget http://www.pjsip.org/release/1.12/pjproject-1.12.tar.bz2
tar -xjf pjproject-1.12.tar.bz2
cd pjproject-1.12/
./configure
make
sudo make install
cd ..

### @export "install-latest-pygments"
hg clone https://bitbucket.org/birkenfeld/pygments-main
cd pygments-main
sudo pip install -e .
cd ..
