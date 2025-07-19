# News App

---

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Demo Videos](#demo-videos)
- [Project Architecture](#project-architecture)
- [State Management](#state-management)
- [Data Flow](#data-flow)
- [Error Handling](#error-handling)
- [Theming & Responsiveness](#theming--responsiveness)
- [Getting Started](#getting-started)

---

## Overview

**News App** is a modern Flutter application that delivers the latest news articles from various sources. It features a
clean UI, robust architecture, and advanced state management using BLoC/Cubit. The app is designed for scalability,
maintainability, and a seamless user experience across platforms.

---

## Features
- 🔍 **Search**: Real-time news search with debounced input.
- 📰 **Article List & Grid**: Toggle between list and grid views for articles.
- 📱 **Responsive UI**: Adapts to different screen sizes using `flutter_screenutil`.
- ⚡ **State Management**: Powered by `flutter_bloc` and `Cubit`.
- 🌐 **API Integration**: Fetches news from remote APIs using `dio`.
- 🧩 **Dependency Injection**: Managed by `get_it`.

---

## Screenshots
> _Add screenshots here_

| Home Screen                          | Article Details                            | Search                                   |
|--------------------------------------|--------------------------------------------|------------------------------------------|
| ![Home](assets/screenshots/home.png) | ![Details](assets/screenshots/details.png) | ![Search](assets/screenshots/search.png) |

---

## Demo Videos
> _Add demo videos here_

- [ ] Home Responsive Demo
- [ ] Article Details Responsive Demo
- [ ] Search Demo

---

## Project Architecture

Here’s a detailed breakdown of the `lib/` directory and its subfolders:


---

## State Management

- **BLoC/Cubit**: The app uses `flutter_bloc` for robust, testable state management.
  - `NewsBloc`: Handles fetching, refreshing, and error states for news articles.
  - `SearchCubit`: Manages debounced search input and triggers news queries.
  - `ViewModeCubit`: Toggles between grid and list views for articles.
- **MultiBlocProvider**: All relevant BLoCs/Cubits are provided at the feature root for composability.

---

## Data Flow

1. **User Interaction**: User searches or toggles view mode.
2. **Event Dispatch**: UI dispatches events to BLoC/Cubit.
3. **Use Case Execution**: BLoC calls domain use cases (e.g., `GetArticles`).
4. **Repository**: Use case invokes repository.
5. **Data Source**: Repository fetches data from API using Api Client (via `dio`) or local mock JSON.
6. **DTO Mapping**: Data is mapped from DTOs to domain entities.
7. **State Update**: BLoC emits new state, updating the UI.
8. **Error Handling**: Failures are caught and surfaced to the UI with retry options.

---

## Error Handling

### Failures vs. Exceptions

- **Exceptions** are technical errors that occur at the infrastructure or data source level (e.g., network issues, server errors, parsing problems). They are thrown by the lower layers (API client, data sources) and are not meant to be shown directly to the user.
- **Failures** are domain-level representations of errors. They are created by catching exceptions and mapping them to user-friendly, business-meaningful error types in the repository layer. The app’s domain and presentation layers only deal with Failures, never raw Exceptions.

**Example Flow:**
- The API client or data source throws a `ServerException` or `NetworkException`.
- The repository catches these exceptions and converts them to a `ServerFailure` or `NetworkFailure`.
- The BLoC receives a `Failure` and updates the UI state accordingly.

This separation ensures that the UI and business logic are decoupled from low-level technical details, making the app more robust, testable, and maintainable.

### Mock Data Source and Use Case
- `NewsMockDataSource` and the mock use case (`GetMockArticles`) are **only for testing and development**.
- In the BLoC, you’ll see a comment:
  ```dart
  /// For testing purposes, we use mock data uncomment the line below and comment the line above
  // final result = await getMockArticles();
  ```
- This means the mock use case is not used in production, but can be enabled for local development or testing scenarios to simulate API responses.

- **Network & Server Errors**: Handled at the API client and repository level, mapped to user-friendly messages.
- **UI Feedback**: Error and empty states are clearly communicated with retry actions.

---

## Theming & Responsiveness
- **Custom Theme**: Material 3, custom color palette, and typography using the Newsreader font.
- **Responsive Design**: `flutter_screenutil` ensures UI scales across devices.
- **Dark Mode**: (Planned) Easily extendable for dark theme support.

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable version)
- Dart

### Installation
```bash
# Clone the repository
$ git clone <repo-url>
$ cd news_app

# Install dependencies
$ flutter pub get

# Run the app
$ flutter run

# Run on web 
$ flutter run -d chrome --web-browser-flag "--disable-web-security"
```

