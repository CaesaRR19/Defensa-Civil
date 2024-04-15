import 'package:defensa_civil/home/home.dart';
import 'package:defensa_civil/pages/login/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiProvider helps us to use the data of the user in every part of the application
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
            home: Scaffold(
              body: HomePage(),
            ),
            // It looked weird with the Debug Banner, so I put it away.
            debugShowCheckedModeBanner: false));
  }
}
