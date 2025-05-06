# Gestion des Compteurs Electriques

![Diagramme de gestion des compteurs](Compteurs.svg)

Les données arrivent par les topics MQTT idoines et sont insérées directement en base.

Une fois par jour, le delta sur une heure est agrégé dans la table d'historisation.
