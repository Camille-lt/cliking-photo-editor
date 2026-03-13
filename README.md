# 📸 Cliking Editor

**Cliking Editor** est une application web interactive d'édition d'images et de messages, conçue avec **Ruby on Rails** et **Tailwind CSS**. Elle offre une expérience utilisateur fluide et immersive, particulièrement optimisée pour la création rapide et le téléchargement direct.

<img width="1421" height="905" alt="Cliking Editor Interface" src="https://github.com/user-attachments/assets/9569de89-fbeb-43d5-94f1-b72b7e653969" />


## ✨ Fonctionnalités

* **Éditeur de message** : Saisie de texte avec compteur de caractères (limite de 300).
* **Aperçu dynamique** : Visualisation instantanée du média téléchargé grâce à JavaScript.
* **Panneau de réglages interactif** : Interface escamotable pour ajuster les filtres et les paramètres d'image.
* **Traitement d'image (MiniMagick)** : 
    * Application de filtres (N&B, Sépia, Froid, Chaud).
    * Ajustements précis via Sliders : intensité, luminosité et contraste.
* **Légende Stylisée (Badge Text)** :
    * Choix de la couleur et du style de fond (Sombre, Clair, Flou).
    * **Rendu Proportionnel** : La taille du texte s'adapte automatiquement à la résolution de l'image source pour un résultat identique à l'aperçu.
* **Téléchargement Direct** : Les images sont traitées à la volée et téléchargées instantanément. Aucune donnée n'est stockée sur le serveur, garantissant la confidentialité.

## 🛠️ Stack Technique

* **Framework** : Ruby on Rails 7+
* **Traitement Image** : ImageMagick & MiniMagick
* **Style** : Tailwind CSS
* **Interactivité** : Hotwire (Stimulus & Turbo)
* **Déploiement** : Render

## 🚀 Installation

1. **Cloner le dépôt**
   ```bash
   git clone [https://github.com/ton-profil/cliking-editor.git](https://github.com/ton-profil/cliking-editor.git)
   cd cliking-editor
Installer les dépendances

Bash
bundle install
Préparer la base de données

Bash
rails db:prepare
Lancer le serveur

Bash
./bin/dev