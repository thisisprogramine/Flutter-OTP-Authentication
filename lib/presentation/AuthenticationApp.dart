import 'package:application_task/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AuthenticationApp extends StatefulWidget {
  @override
  _AuthenticationAppState createState() => _AuthenticationAppState();
}

class _AuthenticationAppState extends State<AuthenticationApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.light(),
      home: LoginScreen(),
    );
  }
}
