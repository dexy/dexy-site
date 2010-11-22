### @export "update-system"
pacman -Sy --noconfirm pacman
pacman -Syu

### @export "install-python"
pacman -Sy --noconfirm "python2"
wget http://pypi.python.org/packages/2.6/s/setuptools/setuptools-0.6c11-py2.6.egg#md5=bfa92100bd772d5a213eedd356d64086
sh setuptools-0.6c11-py2.6.egg


