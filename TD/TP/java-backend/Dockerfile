# Image Java runtime léger
FROM eclipse-temurin:21-jre-alpine

# Dossier de travail dans le container
WORKDIR /app

# Copier le fichier compilé Java
COPY Main.class .

# Commande de lancement
CMD ["java", "Main"]