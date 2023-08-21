# Utilisation de l'image de base Ubuntu
FROM ubuntu:latest

# Mettez à jour les packages et installez des outils supplémentaires
RUN apt-get update && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/*
    
# Exposez les ports nécessaires
EXPOSE 80
EXPOSE 443

# Exécutez une commande de boucle infinie pour maintenir le conteneur actif
CMD ["tail", "-f", "/dev/null"]
