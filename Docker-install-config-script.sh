#!bin/bash
#COPYRIGHT REMAND KNOL - 339249
#configuratie aan de hand van opletten tijdens docker les 
#root maken als nodig
#sudo -i

#update apt-get en install docker
sudo apt-get install -y docker-ce
echo "********* DOCKER IS GEINSTALLEERD HOEZEEE **********" 

#check of docker runt dmv hello world
docker run hello-world
echo "********* Zie je het volgende bericht? Dan goed geinstalleerd **********" 