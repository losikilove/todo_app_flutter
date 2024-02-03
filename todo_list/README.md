# todo_list

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Issue
- Not show the notification alert
    - Solve: add 2 tags below into AndroidManifest.xml
        **<uses-permission android:name="android.permission.VIBRATE" />**
        **<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>**
    - References:
        - https://github.com/MaikuB/flutter_local_notifications/issues/1922
- Not show the schedule notification alert
    - Solve: build flutter_local_notifications with version 13.0.0
    - References: https://github.com/vijayinyoutube/schedule_notification_app_demo/