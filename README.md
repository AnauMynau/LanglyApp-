# Langly: Smart Language Acquisition App

Langly is a high-performance cross-platform mobile application designed to streamline the language learning process. Built with Flutter, this app focuses on immersive UI/UX, reactive state management, and real-time cloud connectivity.

## Key Features

* **Reactive UI:** Smooth transitions and micro-animations using `AnimatedOpacity`, `AnimatedSwitcher`, and `AnimatedContainer`.
* **Smart Search:** Real-time course filtering with persistent local search history.
* **State Management:** Hybrid architecture using **Riverpod** for declarative logic and **Provider** for legacy state sync.
* **Cloud Connectivity:** Integrated **Firebase Cloud Messaging (FCM)** for engagement-driving push notifications.
* **Declarative Navigation:** Seamless routing and deep-linking implementation via **GoRouter**.
* **Dynamic Theming:** Instant light/dark mode switching with persistent cache storage.
* **Production Ready:** Fully signed Android release build (APK) with optimized assets.

## Tech Stack

* **Framework:** Flutter (Dart)
* **Backend:** Firebase (Cloud Messaging, Auth, Firestore)
* **State Management:** Riverpod, Provider
* **Navigation:** GoRouter
* **Build System:** Gradle (Kotlin DSL)

## Project Architecture

Langly follows the **Separation of Concerns** principle to ensure testability and scalability:

* `/models`: Data structures and state management logic.
* `/network`: API services and Firebase communication layer.
* `/navigation`: Declarative routing configuration.
* `/theme`: Custom theme definitions for light/dark modes.

## Testing

The project includes unit and widget tests to ensure the stability of core features like search logic, theme toggling, and button interactions.

Run tests locally:
```bash
flutter test
```
