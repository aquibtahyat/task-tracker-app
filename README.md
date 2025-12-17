# Task Tracker App

A modern, feature-rich task management application built with Flutter, designed to help individuals and teams efficiently organize, track, and manage their tasks with real-time updates and comprehensive task tracking capabilities.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [Technologies & Dependencies](#technologies--dependencies)
- [Testing](#testing)
- [Build & Deployment](#build--deployment)

## Overview

Task Tracker App is a production-ready mobile application that provides a comprehensive solution for task management. The application follows industry-standard software engineering practices, implementing Clean Architecture principles with a clear separation of concerns across data, domain, and presentation layers. Built with Flutter, it offers a seamless cross-platform experience for both iOS and Android devices.

## Features

### Core Functionality
- **Task Management**: Create and update tasks with detailed information
- **Task Categorization**: Organize tasks into three distinct states:
  - **To Do**: Tasks that are pending and need to be started
  - **In Progress**: Tasks currently being worked on
  - **Done**: Completed tasks
- **Time Tracking**: Built-in timer functionality to track time spent on individual tasks
- **Comments System**: Add and view comments on tasks for better collaboration and documentation
- **Task Details**: Comprehensive task detail view with all relevant information
- **Real-time Updates**: Synchronized data updates across the application

### User Experience
- Modern, intuitive Material Design UI
- Smooth navigation with stateful routing
- Responsive layouts optimized for various screen sizes
- Loading states and error handling for better user feedback
- Custom theme with Poppins font family

## Architecture

This application follows **Clean Architecture** principles, ensuring maintainability, testability, and scalability:

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (UI, BLoC/Cubit, Widgets)          │
├─────────────────────────────────────┤
│      Domain Layer                   │
│  (Entities, Use Cases, Repositories)│
├─────────────────────────────────────┤
│      Data Layer                     │
│  (Models, Data Sources, Mappers)    │
└─────────────────────────────────────┘
```

### Key Architectural Patterns
- **BLoC Pattern**: State management using Flutter BLoC/Cubit
- **Dependency Injection**: Injectable for automatic dependency management
- **Repository Pattern**: Abstraction layer between data sources and business logic
- **Use Case Pattern**: Encapsulation of business logic in reusable use cases

## Prerequisites

Before you begin, ensure you have the following installed on your development machine:

### Required Software
- **Flutter SDK**: Version `3.35.0` or higher
- **Dart SDK**: Version `3.9.0` or higher
- **Android Studio** or **Xcode**: For Android/iOS development
- **Git**: For version control

### System Requirements
- **macOS**: For iOS development (if targeting iOS)
- **Windows/Linux/macOS**: For Android development
- **Xcode 14+**: Required for iOS builds (macOS only)
- **Android SDK**: API level 21 or higher

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/aquibtahyat/task-tracker-app
cd task-tracker-app
```

### Step 2: Verify Flutter Installation

Ensure you have Flutter SDK version `3.35.0` or higher installed:

```bash
flutter --version
```

If Flutter is not installed, download it from [flutter.dev](https://flutter.dev/docs/get-started/install) and follow the installation instructions for your operating system.

**Important**: Ensure your Flutter version is `3.35.0` or higher. You can check your current version using `flutter --version`. If you need to upgrade, run:

```bash
flutter upgrade
```

### Step 3: Install Dependencies

```bash
# Install Flutter packages
flutter pub get
```

### Step 4: Generate Code

This project uses code generation for dependency injection, API clients, and JSON serialization. Run the build runner to generate the necessary code:

```bash
# Generate code once
dart run build_runner build --delete-conflicting-outputs

# Or watch for changes during development
dart run build_runner watch --delete-conflicting-outputs
```

**Note**: The `--delete-conflicting-outputs` flag is recommended during development to automatically handle conflicts. For production builds, use `build` instead of `watch`.

## Configuration

### Environment Setup

1. **Flutter Environment**: The project requires Flutter SDK version `3.35.0` or higher. Ensure your Flutter installation meets this requirement.

2. **Dependencies**: All dependencies are defined in `pubspec.yaml`. The project requires:
   - Dart SDK: `^3.9.0`
   - Flutter SDK: `3.35.0` or higher

3. **Code Generation**: The following generated files are created by build_runner:
   - `lib/src/core/injection/injector.config.dart` - Dependency injection configuration
   - `lib/src/data/data_sources/remote/remote_data_source.g.dart` - Retrofit API client
   - Model files with `*.g.dart` extensions - JSON serialization code

### API Configuration

Ensure that the backend API endpoint is properly configured in the network module. The application uses Retrofit for API communication with Dio as the HTTP client.

## Running the Application

### Development Mode

1. **Ensure code generation is complete**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Check for connected devices**:
   ```bash
   flutter devices
   ```

3. **Run the application**:
   ```bash
   # For default device
   flutter run

   # For specific device
   flutter run -d <device-id>

   # For iOS Simulator
   flutter run -d ios

   # For Android Emulator
   flutter run -d android
   ```

### Hot Reload & Hot Restart

During development, you can use:
- **Hot Reload**: Press `r` in the terminal or click the hot reload button in your IDE
- **Hot Restart**: Press `R` in the terminal or click the hot restart button
- **Quit**: Press `q` in the terminal

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## Project Structure

```
lib/
├── app.dart                          # Main application widget
├── main.dart                         # Application entry point
└── src/
    ├── core/                         # Core functionality
    │   ├── base/                     # Base classes and interfaces
    │   │   ├── repository.dart
    │   │   ├── result.dart
    │   │   ├── state.dart
    │   │   └── use_case.dart
    │   ├── injection/                # Dependency injection setup
    │   │   ├── dependencies.dart
    │   │   ├── injector.dart
    │   │   └── injector.config.dart  # Generated file
    │   ├── network/                   # Network configuration
    │   │   ├── error_handler.dart
    │   │   └── network_module.dart
    │   ├── routes/                    # Navigation and routing
    │   │   ├── router.dart
    │   │   └── routes.dart
    │   ├── theme/                     # App theming
    │   │   ├── app_bar_theme.dart
    │   │   ├── app_colors.dart
    │   │   ├── app_dialog_theme.dart
    │   │   ├── app_snackbar_theme.dart
    │   │   ├── app_theme.dart
    │   │   ├── dialog_theme.dart
    │   │   ├── elevated_button_theme.dart
    │   │   ├── floating_action_button_theme.dart
    │   │   ├── input_decoration_theme.dart
    │   │   ├── text_button_theme.dart
    │   │   └── text_theme.dart
    │   └── utils/                     # Utility classes and extensions
    │       ├── extensions/
    │       │   └── snackbar_extension.dart
    │       ├── formatter/
    │       │   └── time_formatter.dart
    │       └── widgets/
    │           ├── center_message_widget.dart
    │           ├── dialog_widget.dart
    │           └── loading_widget.dart
    ├── data/                          # Data layer
    │   ├── data_sources/
    │   │   ├── cache/                 # Local storage
    │   │   │   ├── cache_service.dart
    │   │   │   └── shared_preference_service.dart
    │   │   └── remote/                # API client
    │   │       ├── remote_data_source.dart
    │   │       └── remote_data_source.g.dart  # Generated file
    │   ├── mappers/                   # Data mappers (Entity ↔ Model)
    │   │   ├── add_comment_request_mapper.dart
    │   │   ├── comment_mapper.dart
    │   │   ├── create_task_request_mapper.dart
    │   │   ├── task_mapper.dart
    │   │   └── time_tracking_mapper.dart
    │   ├── models/                    # Data models
    │   │   ├── add_comment_request_model.dart
    │   │   ├── comment_model.dart
    │   │   ├── comment_response_model.dart
    │   │   ├── create_task_request_model.dart
    │   │   ├── task_model.dart
    │   │   ├── task_response_model.dart
    │   │   └── time_tracking_model.dart
    │   └── repositories/              # Repository implementations
    │       └── task_repository_impl.dart
    ├── domain/                        # Domain layer
    │   ├── entities/                  # Business entities
    │   │   ├── add_comment_request_entity.dart
    │   │   ├── comment_entity.dart
    │   │   ├── create_task_request_entity.dart
    │   │   ├── task_entity.dart
    │   │   └── time_tracking_entity.dart
    │   ├── enums/                     # Domain enumerations
    │   │   └── task_type.dart
    │   ├── repositories/              # Repository interfaces
    │   │   └── task_repository.dart
    │   └── use_cases/                 # Business logic use cases
    │       ├── add_comment.dart
    │       ├── create_task.dart
    │       ├── get_comments.dart
    │       ├── get_tasks.dart
    │       └── update_task.dart
    └── presentation/                  # Presentation layer
        └── features/                  # Feature modules
            ├── task_board/            # Task board feature
            │   ├── manager/
            │   │   ├── get_tasks/
            │   │   │   └── get_tasks_cubit.dart
            │   │   ├── task_manager/
            │   │   │   ├── task_manager_cubit.dart
            │   │   │   └── task_manager_state.dart
            │   │   └── timer_tracker/
            │   │       └── time_tracker_cubit.dart
            │   ├── pages/
            │   │   ├── done_page.dart
            │   │   ├── home_shell_page.dart
            │   │   ├── in_progress_page.dart
            │   │   └── to_do_page.dart
            │   └── widgets/
            │       ├── task_card.dart
            │       ├── task_tab_bar.dart
            │       └── task_timer_widget.dart
            ├── task_details/          # Task details feature
            │   ├── manager/
            │   │   ├── add_comment/
            │   │   │   └── add_comment_cubit.dart
            │   │   └── get_comments/
            │   │       └── get_comments_cubit.dart
            │   ├── pages/
            │   │   └── task_details_page.dart
            │   └── widgets/
            │       ├── add_comment_bottom_sheet.dart
            │       ├── comment_card.dart
            │       ├── comments_section.dart
            │       └── task_type_chip.dart
            └── task_form/             # Task form feature
                ├── manager/
                │   └── task_form/
                │       └── task_form_cubit.dart
                └── pages/
                    └── task_form_page.dart
```

## Technologies & Dependencies

### Core Framework
- **Flutter**: `3.35.0` - UI framework
- **Dart**: `^3.9.0` - Programming language

### State Management
- **flutter_bloc**: `^9.1.1` - BLoC pattern implementation
- **bloc**: `^9.1.0` - Core BLoC library
- **equatable**: `^2.0.7` - Value equality comparison

### Dependency Injection
- **injectable**: `^2.5.1` - Code generation for dependency injection
- **get_it**: `^8.2.0` - Service locator

### Networking
- **dio**: `^5.9.0` - HTTP client
- **retrofit**: `^4.7.1` - Type-safe HTTP client generator
- **pretty_dio_logger**: `^1.4.0` - Request/response logging

### Routing
- **go_router**: `^16.0.1` - Declarative routing solution

### Local Storage
- **shared_preferences**: `^2.5.4` - Key-value storage

### Code Generation
- **build_runner**: `^2.5.0` - Code generation tool
- **injectable_generator**: `^2.5.1` - Injectable code generator
- **retrofit_generator**: `^9.7.0` - Retrofit code generator
- **json_serializable**: `^6.9.0` - JSON serialization code generator

### Testing
- **flutter_test**: Flutter testing framework
- **mocktail**: `^1.0.4` - Mocking library for testing

### Development Tools
- **flutter_lints**: `^5.0.0` - Linting rules

## Testing

The project includes comprehensive test coverage:

```bash
# Run all unit and widget tests
flutter test

# Run tests with verbose output
flutter test --verbose

# Run specific test file
flutter test test/path/to/test_file.dart
```

Test files are located in the `test/` directory, mirroring the structure of the `lib/` directory.

## Build & Deployment

### Android Build

```bash
# Build APK
flutter build apk

# Build App Bundle (for Play Store)
flutter build appbundle
```

### iOS Build

```bash
# Build iOS app
flutter build ios

# Build for release
flutter build ios --release
```

**Note**: iOS builds require a Mac with Xcode installed and proper code signing configuration.

### Pre-build Checklist

Before building for production:

1.  Run `flutter pub get`
2.  Run `flutter pub run build_runner build --delete-conflicting-outputs`
3.  Run `flutter test` to ensure all tests pass
4.  Update version numbers in `pubspec.yaml`
5.  Configure API endpoints for production environment
6.  Review and update app icons and splash screens

##  Additional Notes

### Code Generation Workflow

Since this project relies on code generation, it's important to:

1. **Always run build_runner after**:
   - Adding new `@injectable` classes
   - Adding new Retrofit endpoints
   - Adding new JSON serializable models
   - Modifying dependency injection setup

2. **Use watch mode during development**:
   ```bash
   flutter pub run build_runner watch --delete-conflicting-outputs
   ```

3. **Regenerate before commits**:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

### Flutter Version Requirements

Always verify your Flutter version before running commands:

```bash
# Check Flutter version
flutter --version

# Upgrade Flutter if needed
flutter upgrade
```

## Support

For issues, questions, or suggestions, please contact the developer at [github.com/aquibtahyat](https://github.com/aquibtahyat).

---
