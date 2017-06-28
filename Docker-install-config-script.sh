#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#root maken als nodig
#sudo -i

#add GPG key + repostories
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "********* DOCKER KEY ABD REPOSTORIES SET **********"

#update apt-get
sudo apt-get update -y
apt-cache policy docker-ce -y
sudo apt-get install -y docker-ce
echo "********* DOCKER IS GEINSTALLEERD HOEZEEE **********" 