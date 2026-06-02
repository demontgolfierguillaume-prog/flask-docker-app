# flask-docker-app
flask-docker-app

1-1 For which reason is it better to run the container with a flag -e to give the environment variables rather than put them directly in the Dockerfile?
On utilise -e ou .env pour sécuriser les données. En effet, on voudrais pas que le password et le user soit afficher et accecible aux utilisateurs.

1-2 Why do we need a volume to be attached to our postgres container? 
Le volume sert a ne ps perdre toute les données si le container s'arrete ou s'il est supprimé. Le volume est une sorte de mémoire persistante.

1-3 Document your database container essentials: commands and Dockerfile. 
docker build -t my-db .
docker run -d --name my-db -e POSTGRES_DB=db -e POSTGRES_USER=usr -e POSTGRES_PASSWORD=pwd my-db
docker logs my-db
Pour le dockerfile:
FROM postgres:17.2-alpine
COPY init/ /docker-entrypoint-initdb.d/            (scripts effectués au démarrage)

1-4 Why do we need a multistage build? And explain each step of this dockerfile. 
Il permet de séparer le buildde l'exécution. En effet le build est particulièrement long donc on a peu intérêt à les faire ensemble. Le build s'éxécute qu'une fois alors que l'exécution a chaque fois qu'on lance le container ce qui rend l'image plus légère .

1-5 Why do we need a reverse proxy? 
L'interêt d'utiliser un reverse proxy est de :
-cacher le backend
-centraliser les accès (uniquement sur localhost)
-gérer les routes
-améliorer la sécurité
-gérer les https

1-6 Why is docker-compose so important? 
Le docker-compose est important car il nous permet de tout lancer avec une commande, il fait lui meme les réseaux, il créer un ordre de démarrage et lance tout les containers. Sans lui on devrait lancer tout les containers à la main,gérer les réseaux a la main et gérer les dépendances à la main.

1-7 Document docker-compose most important commands. 
docker compose up --build -d  -> pour lancer ou rebuild
docker compose down ->   pour stop
docker compose logs ->   voir les logs
docker compose ps   ->   voir les services

1-8 Document your docker-compose file. 
Dans le docker-compose.yml, on a 3 services :
- Le Backend avec l'API java qui dépend de la database et qui est connecté à db_network et proxy_network pour parler à Postgres et Apache et dont le restart est à on-failure:3
- La database qui stocke les données et est uniquement connecté au réseau db_network et dont le restart est à unless-stopped
- le httpd (Apache) qui est le reverse proxy et accessible avec localhostet qui est connecté que au réseau proxy_network et dont le restart est à unless-stopped

on-failure:3 veut dire que ca va se redémarrer que 3 fois si ca crash (le backend est gourmand en ressouce donc on a pas envie de le redémarrer à l'infinie.
unless-stopped veut dire que ca va redémarrer à l'infinie si on le stop pas manuellement et est particulièrement utile pour une database ou proxy car on a pas vraiment le droit de se permettre qu'ils crashent.

Nos networks:
db_network relie le backend et la database et proxy_network relie apache avec le backend. 

1-9 Document your publication commands and published images in dockerhub. 
Fait
docker tag tp-database:latest guillaumedmg/tp-database:1.0
tag tp-backend:latest guillaumedmg/tp-backend:1.0
docker tag tp-httpd:latest guillaumedmg/tp-httpd:1.0

docker push guillaumedmg/tp-database:1.0
docker push guillaumedmg/tp-backend:1.0
docker push guillaumedmg/tp-httpd:1.0


1-10 Why do we put our images into an online repo?
Ca permet de facilement les partager avec une team, que ca soit accessible depuis n'importe quel pc et pouvoir l'utiliser en production.


Partie github

2-1 What are testcontainers?
Quand j'exécute "mvn clean verify"
Maven lance les tests unitaires et d’intégration
Testcontainers démarre automatiquement un conteneur PostgreSQL et mon application teste réellement l’accès à une base de données réelle (mais temporaire et isolée)
le conteneur est détruit automatiquement
Testcontainers permet de tester ton application dans un environnement proche de la production en utilisant de vrais services (Docker), mais de façon temporaire et automatisée.


2-2 For what purpose do we need to use secured variables ?
On utilise des secured variables (secrets GitHub) pour stocker des informations sensibles sans les exposer dans le code.