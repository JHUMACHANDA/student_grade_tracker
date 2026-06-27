# student_grade_tracker

A new Flutter project.

A simple Flutter (Android) app where a student can add subjects with marks,
see the grade for each subject, and view a live result summary.

## What the app does

- **Add Subject** screen — a form to enter a subject name and a mark (0–100).
  The form validates that the name is not empty and the mark is between 0
  and 100.
- **Subject List** screen — shows every subject in a `ListView.builder`
  with its name, mark, and grade. Swipe a card left to delete it
  (`Dismissible`).
- **Summary** screen — shows total subjects, average mark, passing subjects,
  and overall grade. This updates live the moment a subject is added or
  removed, with no extra taps needed.
- A `BottomNavigationBar` switches between the three screens above.
- An icon button in the `AppBar` toggles between a custom light theme and a
  custom dark theme. Every color in the app comes from `Theme.of(context)`.

## Grading rule

| Mark        | Grade |
|-------------|-------|
| 80 and up   | A     |
| 65 – 79.9   | B     |
| 50 – 64.9   | C     |
| Below 50    | F     |

## Architecture

- `lib/models/subject.dart` — `Subject` class with a private `_mark` field
  and a `grade` getter.
- `lib/providers/subject_provider.dart` — holds the `List<Subject>` and all
  app state for subjects (add, remove, average, overall grade). Uses
  `.where()` to filter passing subjects and `.map()` to extract marks for
  the average.
- `lib/providers/theme_provider.dart` — holds whether dark mode is on.
- `lib/providers/nav_provider.dart` — holds which bottom-nav tab is active.
- `lib/theme/app_themes.dart` — the two custom `ThemeData` objects (light
  and dark).
- `lib/screens/` — the three screens plus `home_screen.dart`, which hosts
  the shared `AppBar` and `BottomNavigationBar`.

All state is managed with the **Provider** package. There is no `setState`
call anywhere in the app.

## How to run

1. Install the [Flutter SDK]
   and make sure `flutter doctor` shows no blocking issues.
2. Clone the project and install packages:
bash
   git clone 
   cd student_grade_tracker
   flutter pub get

3. Plug in an Android device (with USB debugging on) or start an Android
   emulator.
4. Run the app:
bash
   flutter run
5. To build a release APK:
```bash
   flutter build apk --release
```
The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.

## Tech

- Flutter (Material 3)
- [provider](https://pub.dev/packages/provider) for state management

