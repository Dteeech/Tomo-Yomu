# TomoYomu (栞読む) - Documentation Projet

> "Marque-page Lecture" - Application mobile de tracking de lecture de mangas avec système de recommandations intelligentes.
> 

[<img src="https://img.shields.io/badge/Flutter-3.35.6-02569B?logo=flutter" alt="Flutter Version" />](https://flutter.dev/)[<img src="https://img.shields.io/badge/Firebase-Latest-FFCA28?logo=firebase" alt="Firebase" />](https://firebase.google.com/)[<img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License" />](https://www.notion.so/LICENSE)

---

## 📚 Vision du Projet

**TomoYomu** résout un problème concret : **la difficulté à suivre sa progression de lecture sur plusieurs mangas et découvrir de nouveaux titres adaptés à ses goûts**.

L'application combine tracking de lecture, gestion de bibliothèque personnelle et recommandations intelligentes basées sur vos préférences.

---

## ✨ Fonctionnalités Principales

### MVP (Version 1)

### 1️⃣ Gestion de Bibliothèque

- ➕ Ajouter des mangas à votre liste
- 📖 Tracker le chapitre actuel
- ⭐ Système de notation (1-5 étoiles)
- 🏷️ Statuts personnalisés :
    - 📚 En cours
    - ✅ Terminé
    - ❌ Abandonné
    - 🔖 À lire

### 2️⃣ Liens Directs vers Sites de Scan

Choix du site préféré par manga lors de l'ajout :

- 🍣 [Sushi-Scan](https://sushiscan.net/)
- 🇫🇷 [Scan-VF](https://www.scan-vf.net/)
- 🇯🇵 [JapScan](https://www.japscan.lol/)
- 📱 [LelScan](https://lelscanvf.cc/)
- 📖 [Scan-Manga](https://www.scan-manga.com/)

**Bouton "Lire chapitre X"** générant automatiquement le lien direct.

### 3️⃣ Système de Recommandations

- 🎯 Basé sur vos notes attribuées
- 🧬 Analyse des genres de mangas appréciés
- 🔗 Utilisation de l'API Jikan (MyAnimeList)

---

## 🏗️ Architecture Technique

### Stack Technologique

```yaml
# Framework
Flutter: 3.35.6

# Backend
Firebase:
  - Firestore (Stockage données)
  - Authentication (Auth Anonyme Phase 1)

# API Externe
Jikan API v4 (MyAnimeList)

```

### Packages Principaux

```yaml
dependencies:
  # State Management
  provider: ^6.1.1

  # Backend
  firebase_core: latest
  cloud_firestore: latest
  firebase_auth: latest

  # API Calls
  http: ^1.1.0

  # UI
  cached_network_image: ^3.3.0
  flutter_rating_bar: ^4.0.1

```

---

## 📱 Structure des Écrans

### Navigation (6 écrans principaux)

```
🚀 SplashScreen
   ├── Logo + animation chargement
   └── Initialisation Firebase

📖 Onboarding (1ère utilisation)
   ├── Présentation app (3-4 slides)
   └── Explications des features

🏠 Home (Ma Bibliothèque)
   ├── Liste des mangas
   ├── Filtres/Tri :
   │   ├── Par statut
   │   ├── Par note
   │   └── Par ordre alphabétique
   ├── SearchBar
   └── FAB (bouton) "Ajouter manga"

➕ Ajouter Manga
   ├── Recherche API Jikan
   ├── Sélection résultat
   └── Configuration initiale

📝 Détails Manga
   ├── Infos complètes
   ├── Gestion chapitre actuel
   ├── Modification note/statut
   └── Bouton "Lire"

🎯 Recommandations
   ├── Suggestions personnalisées
   └── Cartes manga

```

---

## 🗄️ Structure Firestore

```jsx
// users/{userId}/mangas/{mangaId}
{
  id: number,              // ID MyAnimeList
  title: string,
  imageUrl: string,
  status: string,             // "reading" | "completed" | "dropped" | "plan_to_read"
  rating: number,             // 1-5
  currentChapter: number,
  totalChapters: number?,
  genres: string[],
  scanSite: string,           // Site de lecture préféré
  scanSlug: string,           // Slug du manga sur le site
  addedAt: timestamp,
  updatedAt: timestamp
}

```

---

## 🔐 Authentification - Stratégie en 2 Phases

### Phase 1 : MVP (Priorité) ✅

**Firebase Anonymous Authentication**

- ⚡ Setup rapide (~30 min)
- 🚫 Aucune friction utilisateur
- 🆔 `userId` auto-généré
- ☁️ Synchro cloud immédiate

### Phase 2 : Upgrade (Si temps disponible) 🔄

**OAuth (Google)**

- 📱 Google Sign-In
- 🔄 Migration données anonymes vers compte

> Raison : Priorité aux features métier, OAuth = amélioration future
> 

---

## 🚀 Installation et Démarrage

### Prérequis

```bash
Flutter 3.35.6
Dart SDK
Firebase CLI

```

### Installation

```bash
# Clone du repository
git clone https://github.com/Dteeech/Tomo-Yomu.git
cd TomoYomu

# Installation des dépendances
flutter pub get

# Configuration Firebase
flutterfire configure

```

### Lancer l'application

```bash
# Debug
flutter run

# Release
flutter build apk --release  # Android
flutter build ios --release  # iOS

```

---

## 📂 Structure du Projet

```
lib/
├── core/
│   ├── constants/        # URLs API, couleurs, strings
│   ├── models/           # Manga, User
│   └── services/         # Firebase, Jikan API
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── manga_details/
│   ├── add_manga/
│   └── recommendations/
│
├── shared/
│   ├── widgets/          # Composants réutilisables
│   └── providers/        # State management
│
└── main.dart

```

---

## 🎮 Roadmap & Idées Futures

### Gamification 🎯

- Système de badges/réalisations
- Statistiques de lecture
- Objectifs mensuels

### Papier 📚

- Liens vers boutiques mangas physiques

### Social 👥

- Partage de listes entre amis
- Discussions sur les mangas
- Reviews communautaires
- 

---

## 👨‍💻 Auteur

**Marshall Isaac**

- GitHub: [@Dteeech](https://github.com/Dteeech)
- Email: [isaak.marshall6@gmail.com](mailto:isaak.marshall6@gmail.com)

---

## 🙏 Remerciements

- [Jikan API](https://jikan.moe/) pour l'accès aux données MyAnimeList
- [Firebase](https://firebase.google.com/) pour l'infrastructure backend
- Communauté Flutter pour les packages open-source

---