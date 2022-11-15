#!/bin/sh

# install and update packages
yes Yes | sudo apt-get update
yes Yes | sudo apt-get install python3 nginx python3-venv python3-pip python3-dev

# set ip
ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
sed -i "s/x.x.x.x/$ip/g" ./flaskapp

# copy files
mkdir -p www/flaskapp
cp ./*.py ./www/flaskapp
sudo cp ./flaskapp.service /etc/systemd/system/
sudo cp ./flaskapp /etc/nginx/sites-available

# firewall
sudo iptables -I INPUT -p tcp --dport 5000 -j ACCEPT

# virtual environment
cd www/flaskapp
python3 -m venv flaskenv
sudo chmod 755 flaskenv/
sudo source flaskenv/bin/activate
/home/stjepan/www/flaskapp/flaskenv/bin/pip3 install virtualenv
/home/stjepan/www/flaskapp/flaskenv/bin/pip3 install gunicorn
/home/stjepan/www/flaskapp/flaskenv/bin/pip3 install flask
/home/stjepan/www/flaskapp/flaskenv/bin/pip3 install wheel
/home/stjepan/www/flaskapp/flaskenv/bin/pip3 install jsonpickle

# service
sudo systemctl start flaskapp.service
sudo systemctl restart flaskapp.service
sudo systemctl enable flaskapp

# nginx
sudo ln -s /etc/nginx/sites-available/flaskapp /etc/nginx/sites-enabled
sudo sed -i "1s/.*/user root;/" /etc/nginx/nginx.conf
sudo nginx -t
sudo systemctl restart nginx

# firewall
sudo ufw allow 'Nginx Full'