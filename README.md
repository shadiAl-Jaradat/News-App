# News App

**News App** is a modern Flutter application that delivers the latest news articles from various sources. It features a
clean UI, robust architecture, and advanced state management using BLoC/Cubit.

<img width="400" height="400" alt="newsAppRounded" src="https://github.com/user-attachments/assets/09d32bd1-95be-4b2e-a63d-98b2352f452c" />

---

## Table of Contents
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

## Features
- 🔍 **Search**: Real-time news search with debounced input.
- 📰 **Article List & Grid**: Toggle between list and grid views for articles.
- 📱 **Responsive UI**: Adapts to different screen sizes using `flutter_screenutil`.
- ⚡ **State Management**: Powered by `flutter_bloc` and `Cubit`.
- 🌐 **API Integration**: Fetches news from remote APIs using `dio`.
- 🧩 **Dependency Injection**: Managed by `get_it`.

---

## Screenshots

| Home Screen                          | Article Details                            | Search                                   |
|--------------------------------------|--------------------------------------------|------------------------------------------|
|<img width="1179" height="2556" alt="image" src="https://github.com/user-attachments/assets/487d5a4b-ee7d-4e13-a3e6-6b8b9d734e38" />|<img width="1179" height="2556" alt="image" src="https://github.com/user-attachments/assets/382f030b-26ae-4e4d-976c-1b3598bb9a4b" />|<img width="1179" height="2556" alt="image" src="https://github.com/user-attachments/assets/6149683d-c874-43e1-905f-d937383929c2" />|



| Shimmer Loading                      | No Search Found                            | Error View                               |
|--------------------------------------|--------------------------------------------|------------------------------------------|
|<img width="1179" height="2556" alt="image" src="https://github.com/user-attachments/assets/1b55f35d-a481-4fe0-b62b-f586b36ce264" />|<img width="1179" height="2556" alt="image" src="https://github.com/user-attachments/assets/72f8fa7d-0a8e-441e-8de5-dbc82a674b97" />|<img width="1179" height="2556" alt="image" src="https://github.com/user-attachments/assets/0642f6d4-5ecc-4823-8169-5b1edd3ebb92" />|

---

## Demo Videos

- [ ] Home Responsive Demo

https://github.com/user-attachments/assets/694ae490-5aa7-448a-8850-e56e0e35f8d7

- [ ] Article Details Responsive Demo

https://github.com/user-attachments/assets/241aafae-de06-4ca6-b44c-8c811a2080cc

- [ ] Search Demo

https://github.com/user-attachments/assets/abb159ab-a527-4f3d-ad08-778fe5939564


---

## Project Architecture

Here's a detailed breakdown of the `lib/` directory and its subfolders:
<img width="1246" height="1680" alt="newsappArc" src="https://github.com/user-attachments/assets/55a6008a-7b99-498b-bcf8-4ad82a9eaa33" />


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
5. **Data Source**: Repository fetches data from API using Api Client (via `dio`) or local mock JSON (Testing).
6. **DTO Mapping**: Data is mapped from DTOs to domain entities.
7. **State Update**: BLoC emits new state, updating the UI.
8. **Error Handling**: Failures are caught and surfaced to the UI with retry options.

---

## Error Handling

### Failures vs. Exceptions

- **Exceptions** are technical errors that occur at the infrastructure or data source level (e.g., network issues, server errors, parsing problems). They are thrown by the lower layers (API client, data sources) and are not meant to be shown directly to the user.
- **Failures** are domain-level representations of errors. They are created by catching exceptions and mapping them to user-friendly, business-meaningful error types in the repository layer. The app's domain and presentation layers only deal with Failures, never raw Exceptions.

**Example Flow:**
- The API client or data source throws a `ServerException` or `NetworkException`.
- The repository catches these exceptions and converts them to a `ServerFailure` or `NetworkFailure`.
- The BLoC receives a `Failure` and updates the UI state accordingly.

This separation ensures that the UI and business logic are decoupled from low-level technical details.

### Mock Data Source and Use Case
- `NewsMockDataSource` and the mock use case (`GetMockArticles`) are **only for testing and development**.
- In the BLoC, you'll see a comment:
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

----

### Code Style

#### Imports

- Order:
  1- Dart/Flutter SDK imports
  2- Third-party package imports
  3- Project imports (using `package:news_app/...`)

- No relative imports across modules; always  use `package:news_app/...` for internal imports.


#### File & Folder Structure

Follow feature-first and DDD-inspired structure
```
lib/
    core/
    features/
      news/
        data/
        domain/
        presentation/
    shared/
    app/
```

Use snake_case for file and folder names.

Use PascalCase for class names.


#### Formatting

- Always run 
`dart format -l 140 --set-exit-if-changed .`before committing.
- Keep lines under 140 characters when possible.
- Remove unused imports and variables.

----

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
