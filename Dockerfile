# Utilisation de l'image de base Ubuntu
FROM ubuntu:18.04

# Mettez à jour les packages et installez des outils supplémentaires
RUN apt-get update && \
    # Python dependencies
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    # Install Python 2.7 and other packages
    apt install -y curl nano python2.7 sudo wget && \
    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
    python2.7 get-pip.py && \
    pip install docker-py && \
    rm -rf /var/lib/apt/lists/* && \
    apt update
    
# Python install source : 
# https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/
    
# Exposez les ports nécessaires
EXPOSE 80
EXPOSE 443
EXPOSE 5432

# Exécutez une commande de boucle infinie pour maintenir le conteneur actif
CMD ["tail", "-f", "/dev/null"]
