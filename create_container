# Utilisation de l'image de base Ubuntu
FROM ubuntu:latest

# Utilisateurs
ARG jira=true
ARG confluence=true
ARG bitbucket=false

# Utilisation de la variable dans l'environnement de construction
ENV JIRA=$jira
ENV CONFLUENCE=$confluence
ENV BITBUCKET=$bitbucket

# Définit la variable d'environnement DEBIAN_FRONTEND sur noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Mettez à jour les packages et installez des outils supplémentaires
RUN apt-get update && \
    apt-get install -y openssh-server openssh-client apache2 postgresql sudo net-tools && \
    rm -rf /var/lib/apt/lists/*

# Générez des clés SSH pour le conteneur
RUN ssh-keygen -A

# Vérifiez si l'utilisateur "ubuntu" existe déjà
#RUN if ! id -u ubuntu > /dev/null 2>&1; then \
RUN        useradd -m -s /bin/bash ubuntu && \
        echo 'ubuntu:ubuntu' | chpasswd;
#\
#    fi

# Ajoutez un utilisateur postgres
RUN if ! id -u postgres > /dev/null 2>&1; then \
RUN        useradd -m -s /bin/bash postgres && \
        echo 'postgres:postgres' | chpasswd; \
    fi

# Vérifier si l'utilisateur Jira doit etre cree
RUN if [ "$JIRA" = "true" ]; then \
        useradd -m -s /bin/bash jira && \
        echo 'jira:jira' | chpasswd; \
    fi

# Ajoutez un utilisateur confluence
RUN if [ "$CONFLUENCE" = "true" ]; then \
        useradd -m -s /bin/bash confluence && \
        echo 'confluence:confluence' | chpasswd; \
    fi

# Ajoutez un utilisateur bitbucket
RUN if [ "$BITBUCKET" = "true" ]; then \
        useradd -m -s /bin/bash bitbucket && \
        echo 'bitbucket:bitbucket' | chpasswd; \
    fi

# Exécutez le serveur SSH au démarrage du conteneur
CMD ["/usr/sbin/sshd", "-D"]

# Exécutez une commande de boucle infinie pour maintenir le conteneur actif
CMD ["tail", "-f", "/dev/null"]
