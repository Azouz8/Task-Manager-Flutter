# Task Manager Flutter App

A modern Flutter task management application that uses local Hive storage and Flutter BLoC for state management. The app provides task organization, Eisenhower matrix support, profile tracking, and category management through an intuitive mobile UI.

## Screens
<img width="250" alt="Screenshot 2026-06-29 200151" src="https://github.com/user-attachments/assets/c76b1132-d462-40be-b520-06fec75e96e9" />
<img width="250" alt="Screenshot 2026-06-29 200058" src="https://github.com/user-attachments/assets/608fe942-7a3b-40c9-a52c-f2194481ce29" />
<img width="250" alt="Screenshot 2026-06-29 200159" src="https://github.com/user-attachments/assets/dd0313f1-959c-4437-bc1a-913cf71badb1" />
<img width="250" alt="Screenshot 2026-06-29 200207" src="https://github.com/user-attachments/assets/fd4419e7-939f-45f3-a734-c25dce2520ee" />
<img width="250" alt="Screenshot 2026-06-29 200219" src="https://github.com/user-attachments/assets/9695d49f-ba1b-43da-af8a-52d6772ee12e" />
<img width="250" alt="Screenshot 2026-06-29 200237" src="https://github.com/user-attachments/assets/8b6f438a-7993-4f0c-a8c8-beab475bc51f" />


## Key Features

- Task creation, editing, and deletion
- Local persistence with Hive
- Task prioritization using Eisenhower categories
- Home task list, matrix view, and profile dashboard
- Custom task cards, date selection, and category selection
- Material design theme with responsive UI

## Architecture

- Flutter with `flutter_bloc` for business logic
- `Hive` for local data storage and model adapters
- Repository layer for task data access
- Organized UI with separate screens and widgets

## Project Structure

- `lib/main.dart` – App entry point
- `lib/cubits/` – BLoC state management classes
- `lib/models/` – Task and user profile models and Hive adapters
- `lib/repos/` – Task repository implementation
- `lib/screens/` – Main app screens: layout, home, matrix, profile
- `lib/widgets/` – Reusable widgets and form components
- `lib/services/` – Hive service utilities
- `lib/theme/` – App colors and theme definitions

## Dependencies

- `flutter_bloc`
- `hive`
- `hive_flutter`
- `google_fonts`
- `intl`
- `uuid`
- `dotted_border`

## Getting Started

### Prerequisites

- Flutter SDK installed
- Android Studio, Xcode, or compatible device/emulator

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

### Generate Hive adapters

If you update model classes, regenerate Hive adapters:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Usage

1. Launch the app
2. Create a new task with title, category, and due date
3. View tasks in the home list and Eisenhower matrix
4. Track progress in the profile screen

## Notes

- Task data is stored locally on the device using Hive
- The app is currently configured for development and not published to `pub.dev`

## Contact

For improvements, bug fixes, or feature requests, update the repository and add a detailed issue or pull request.
