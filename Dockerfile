# Utilisation de l'image de base Ubuntu
FROM ubuntu:18.04

# Mettez à jour les packages et installez des outils supplémentaires
RUN apt-get update && \
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get install -y sudo python3.9 && \
    cd /usr/lib/python3/dist-packages && \
    ln -s apt_inst.cpython-310-x86_64-linux-gnu.so apt_inst.so && \
    ln -s apt_pkg.cpython-310-x86_64-linux-gnu.so apt_pkg.so
    rm -rf /var/lib/apt/lists/*
# Python install source : 
# https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/
# https://stackoverflow.com/questions/63680554/ansible-install-python3-apt-package
    
# Exposez les ports nécessaires
EXPOSE 80
EXPOSE 443

# Exécutez une commande de boucle infinie pour maintenir le conteneur actif
CMD ["tail", "-f", "/dev/null"]
