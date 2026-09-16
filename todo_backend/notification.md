# Notification System Implementation Details

This document summarizes all the packages, new files, and modifications made to implement both **Remote Push Notifications (FCM)** and **Scheduled Local Notifications (Reminders)** in the Todo App.

## 📦 Packages Added (`pubspec.yaml`)
- `firebase_messaging`: For handling remote push notifications via Firebase.
- `flutter_local_notifications`: For showing foreground notification banners and scheduling local offline alarms.
- `timezone` & `flutter_timezone`: To fetch the device's true local timezone (e.g., IST) so reminders trigger at the correct exact local time.
- `googleapis_auth`: To generate OAuth2 Bearer tokens for the FCM HTTP v1 API.

## 🆕 New Files Created
- **`lib/service/notification_service.dart`**
  - A singleton class responsible for initializing `flutter_local_notifications` and setting the device timezone (`Asia/Kolkata` / Local).
  - Contains the `scheduleNotification` function that handles the exact Date/Time alarm setup.
- **`lib/screens/send_notification.dart`**
  - A UI screen that allows users to send instant remote FCM push notifications to other users in the database using the Firebase HTTP v1 API.

## 🔄 Existing Files Modified

### Android Native Configuration
- **`android/app/build.gradle.kts`**
  - Enabled `isCoreLibraryDesugaringEnabled = true`.
  - Added the `coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")` dependency (required by the latest local notifications package to process Dates/Times on older Android versions).
- **`android/app/src/main/AndroidManifest.xml`**
  - Added permissions: `POST_NOTIFICATIONS`, `SCHEDULE_EXACT_ALARM`, `USE_EXACT_ALARM`, and `RECEIVE_BOOT_COMPLETED`.
  - Added `<receiver>` tags inside the `<application>` block so alarms persist even if the phone reboots.

### App Initialization & Handlers
- **`lib/main.dart`**
  - Triggered the initialization of `NotificationService()`.
  - Requested Android 13+ / iOS notification permissions from the user on startup.
  - Added a background FCM listener (`FirebaseMessaging.onBackgroundMessage`).
  - Added a foreground FCM listener (`FirebaseMessaging.onMessage.listen`) that manually triggers a local heads-up popup banner when the app is actively open on the screen.

### Authentication & Token Management
- **`lib/service/auth_service.dart`**
  - Added logic in `saveUserToken()` to fetch the device's unique FCM Token (`FirebaseMessaging.instance.getToken()`) and merge it into the user's document in the `users` Firestore collection.
  - Ensured this token is updated every time a user signs in or signs up.

### UI & Models (Reminders)
- **`lib/data/todo_entry_model.dart`**
  - Added a `reminderDateTime` field to save the scheduled alarm time to Firestore.
- **`lib/widgets/add_entry_bottom.dart`**
  - Added `showDatePicker` and `showTimePicker` UI buttons.
  - Hooked up `NotificationService().scheduleNotification` to fire when the user clicks submit.
  - Wrapped the entire bottom sheet in a `SingleChildScrollView` to prevent the keyboard from causing a "RenderFlex overflowed" crash.
- **`lib/widgets/todo_entry_card.dart`**
  - Updated the UI to display a small ⏰ alarm icon and the scheduled time if a reminder exists for that task.
- **`lib/screens/todo_home.dart`**
  - Added a bell icon (`Icons.notifications`) in the top `AppBar` to navigate to the `SendNotificationScreen`.
