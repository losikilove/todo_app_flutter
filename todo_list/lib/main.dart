import 'package:flutter/material.dart';
import 'package:todo_list/utils/local_notifications.dart';

import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifications().init();
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
