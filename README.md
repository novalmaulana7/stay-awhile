# Stay Awhile

A mobile application for discovering and sharing interesting places nearby, powered by Firebase and real-time geolocation.

## Description

Stay Awhile is a Flutter-based mobile app that helps users explore their surroundings and find interesting places. Users can "drop" location markers, browse nearby drops from other users, and interact with a community-driven map experience. The app features Firebase authentication (email, Google, Apple), real-time Firestore database, and an interactive map with geolocation-based filtering.

### Key Features

- **Authentication** — Sign up / sign in with email, Google, and Apple
- **Explore Map** — Interactive map (flutter_map) showing nearby drops
- **Drop Posts** — Share a location drop with a message
- **Dashboard** — View recent drops and activity
- **User Profile** — Manage your account and view your drops

## How to Install and Run the Project

### Prerequisites

- Flutter SDK (>= 3.10.8)
- Dart SDK
- Firebase project configured for your app
- Android Studio / VS Code
- A physical device or emulator with Google Play Services

### Installation

```bash
# Clone the repository
git clone https://github.com/novalmaulana/stay_awhile_mobile.git
cd stay_awhile_mobile

# Install dependencies
flutter pub get

# Configure Firebase
# Place your google-services.json (Android) and GoogleService-Info.plist (iOS)
# in the respective platform folders.

# Run the app
flutter run
```

## How to Use the Project

1. **Sign Up / Sign In** — Create an account or log in using email, Google, or Apple.
2. **Explore** — Browse the map to see drops made by other users around you.
3. **Drop** — Tap the drop button to share a location and message with the community.
4. **Profile** — View and manage your account information and drop history.

## Credits

- **novalmaulana** — Project owner and lead developer
- [Flutter](https://flutter.dev) — UI framework
- [Firebase](https://firebase.google.com) — Backend services (Auth, Firestore)
- [flutter_map](https://github.com/fleaflet/flutter_map) — Map rendering
- [geoflutterfire_plus](https://pub.dev/packages/geoflutterfire_plus) — Geolocation queries
- [Provider](https://pub.dev/packages/provider) — State management
- [GetIt](https://pub.dev/packages/get_it) — Dependency injection
- [GoRouter](https://pub.dev/packages/go_router) — Declarative routing

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
