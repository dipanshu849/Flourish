# Flourish

A Flutter-based marketplace application for the IIT Mandi community, enabling students to securely and sustainably buy and sell items within the campus.

**APP LINK TO DOWNLOAD FOR ANDROID:**  
[Download Flourish](https://drive.google.com/file/d/1FWaNKYD2_f9rffQVgkGZOWB3LfP49vMc/view?usp=drivesdk)

---

## Improvements & Highlights

- **Modern, User-Friendly UI:**  
  The app features clean navigation tabs (Home, Chats, Sell, Wishlist, Account) and intuitive layouts for listings and chat, as shown in the screenshots below.
- **In-App Chat Functionality:**  
  Users can directly chat with sellers and buyers within the app for convenient, secure communication.
- **Dynamic Marketplace:**  
  Real-time product listing, browsing by category, and wishlist management.
- **Discount & Pricing Display:**  
  Clearly shows discounts, original and sale prices, and product conditions to facilitate informed decisions.
- **Secure Authentication:**  
  Supabase-backed sign-in/sign-up restricted to @iitmandi.ac.in community.
- **Sustainable Campus Focus:**  
  Encourages reuse and reduces waste.

---

## Screenshots

| Home Screen                                 | Product Details                              |
|----------------------------------------------|----------------------------------------------|
| ![WhatsApp Image 2025-06-26 at 13 39 44](https://github.com/user-attachments/assets/99aaee28-b9d2-4168-8ce6-66359aadfc75) | ![WhatsApp Image 2025-06-26 at 13 39 45](https://github.com/user-attachments/assets/d718feb7-c128-446c-8b00-744f2aa1849b) |

| Chat List                                   | Chat Conversation                            |
|----------------------------------------------|----------------------------------------------|
| ![WhatsApp Image 2025-06-26 at 13 39 46(1)](https://github.com/user-attachments/assets/9b0d6f16-4e87-4f54-903b-10552dbab59f) | ![WhatsApp Image 2025-06-26 at 13 39 46](https://github.com/user-attachments/assets/46f36171-102a-49f5-8601-17281854dc03) |

---

## Getting Started

This project is a Flutter application designed to facilitate a trusted and sustainable marketplace for the IIT Mandi campus.

### Prerequisites

- **Flutter SDK:** [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Android SDK:** [Set up Android Studio](https://developer.android.com/studio)

### Running the Project

1. Open the project in your IDE (VS Code/Android Studio).
2. Navigate to `lib/main.dart`.
3. Run `flutter pub get` to install dependencies.
4. Launch with `flutter run` on your connected device or emulator.

---

## Project Structure

- `lib/main.dart`: Entry point.
- `lib/app.dart`: App-wide configuration.
- `lib/src/features/screens/`: Main frontend screens.
- `lib/src/auth/`: Authentication logic.
- `lib/src/util/theme/`: Custom theming.
- `lib/src/util/constants/`: App constants.

---

## Key Features

- **Authentication:** Secure, email-validated sign-in/sign-up using Supabase.
- **Marketplace:** List, browse, and search products within the campus community.
- **User Profiles:** Manage user details and preferences.
- **In-App Chat:** Real-time communication between buyers and sellers.
- **Sustainability:** Promotes reuse of items to reduce campus waste.

---

## Dependencies

- **Supabase:** Backend services (auth, database).
- **GetX:** State management and navigation.
- **Image Picker:** Product image uploads.
- **Intl:** Date/time formatting.

---

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Supabase Documentation](https://supabase.io/docs)
- [GetX Documentation](https://pub.dev/packages/get)

---

*For suggestions and contributions, please open an issue or submit a pull request!*
