import 'package:flutter/material.dart';
import '../widgets/reminder_navigation_bar.dart';
 

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Reminder',
      theme: ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 27, 209, 93),
          surface: const Color.fromARGB(255, 27, 209, 93),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const ReminderScreen(),
    );
  }
}
