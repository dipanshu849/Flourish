APP LINK TO DOWNLOAD FOR ANDROID - https://drive.google.com/file/d/1FWaNKYD2_f9rffQVgkGZOWB3LfP49vMc/view?usp=drivesdk

# Flourish

A Flutter-based marketplace application for the IIT Mandi community, enabling students to buy and sell items within the campus securely and sustainably.

---

## Getting Started

This project is a Flutter application designed to facilitate a trusted and sustainable marketplace for the IIT Mandi campus. Below are the steps to set up and run the project.

---

### Prerequisites

Before running the project, ensure you have the following installed:

1. **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install)
2. **Android SDK**: [Set up Android Studio](https://developer.android.com/studio)
3. **Dependencies**: All dependencies are listed in `pubspec.yaml`.

---

### Running the Project

1. **Open the Project**:
   - Open the project in your preferred IDE (e.g., VS Code, Android Studio).
   - Navigate to the `main.dart` file located in `lib/main.dart`.

2. **Run the Application**:
   - Open the terminal in your IDE (`Ctrl + Shift + `` in VS Code).
   - Run the following command:
     ```bash
     flutter run
     ```
   - Ensure your emulator or physical device is connected and running.

---

## Project Structure

The project follows a modular structure for better organization and scalability. Here's an overview of the repository structure:


lib/
│
├── main.dart          # Entry point of the application
├── app.dart           # Root app configuration
│
└── src/
    ├── features/
    │   └── screens/   # Main frontend screens
    │
    ├── auth/          # Authentication logic (Sign in/Sign up)
    │
    └── util/          # App-wide utilities
        ├── theme/     # Custom theme configurations
        └── constants/ # App constants

### Key Features

1. **Authentication**:
   - Secure sign-in and sign-up using Supabase.
   - Email validation for `@iitmandi.ac.in` and `@students.iitmandi.ac.in` domains.

2. **Marketplace**:
   - List products for sale with details like title, price, description, and images.
   - Browse and search for products within the campus community.

3. **User Profile**:
   - Manage user details, listed products, and preferences.

4. **Sustainability**:
   - Promote reuse and reduce waste by enabling students to sell unused items.

---

### Dependencies

The project uses the following key dependencies (managed in `pubspec.yaml`):

- **Supabase**: For backend services (authentication, database).
- **GetX**: For state management and navigation.
- **Image Picker**: For uploading product images.
- **Intl**: For date and time formatting.

---

### Notes on Structure

- The project was designed with a modular structure in mind, but due to time constraints, some deviations may exist.
- Efforts were made to maintain separation of concerns, with `utils/` handling shared resources like themes and constants, and `auth/` managing authentication logic.
- Supabase integration is used for backend services, ensuring secure and scalable data management.

---

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Documentation](https://supabase.io/docs)
- [GetX Documentation](https://pub.dev/packages/get)

---
