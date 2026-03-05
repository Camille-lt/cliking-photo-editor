# 📸 Cliking Editor
<img width="1356" height="802" alt="Capture d’écran 2026-03-05 à 20 03 27" src="https://github.com/user-attachments/assets/dd930148-dd96-484d-a211-545528d4be6a" />
<img width="1352" height="874" alt="Capture d’écran 2026-03-05 à 20 06 12" src="https://github.com/user-attachments/assets/f311de8e-7add-4b53-bb6d-b89632ccd490" />

**Cliking Editor** est une application web interactive d'édition d'images et de messages, conçue avec **Ruby on Rails** et **Tailwind CSS**. Elle offre une expérience utilisateur fluide et immersive, particulièrement optimisée pour les appareils mobiles.

## ✨ Fonctionnalités

* **Éditeur de message** : Saisie de texte avec compteur de caractères (limite de 300).
* **Aperçu dynamique** : Visualisation instantanée du média téléchargé.
* **Panneau de réglages interactif** : Interface escamotable pour ajuster les filtres et les paramètres d'image.
* **Filtres d'image** : Application de filtres (N&B, Sépia, Froid, Chaud) en temps réel via CSS.
* **Ajustements précis** : Sliders pour régler l'intensité, la luminosité et le contraste.
* **Design Responsive** : 
    * **Desktop** : Layout en deux colonnes avec zone de texte encadrée et centrée.
    * **Mobile** : Interface "Full Screen" avec panneau coulissant optimisé pour masquer la zone de texte lors des réglages.

## 🛠️ Stack Technique

* **Framework** : Ruby on Rails 7+
* **Style** : Tailwind CSS
* **Interactivité** : JavaScript (Vanilla) & Hotwire/Turbo
* **Base de données** : PostgreSQL (Production) / SQLite (Local)

## 🚀 Installation

1. **Cloner le dépôt**
   ```bash
   git clone [https://github.com/ton-profil/cliking-editor.git](https://github.com/ton-profil/cliking-editor.git)
   cd cliking-editor
Installer les dépendances

**Bash**
bundle install
yarn install
Préparer la base de données

**Bash**
rails db:create
rails db:migrate
Lancer le serveur

**Bash**

./bin/dev
