import 'package:flutter/material.dart';
import 'package:flutter_application_1/Admin/AdminScreen.dart';
import 'package:flutter_application_1/LoginScreen.dart';
import 'package:flutter_application_1/Tendik/TendikScreen.dart';
import 'package:flutter_application_1/auth_provider.dart';
import 'package:flutter_application_1/main.dart';
import 'package:provider/provider.dart';
import 'BottomBarScreen.dart';

class WelcomeScreen extends StatelessWidget {
  void redirectToDashboard(BuildContext context, AuthProvider authProvider) {
  if (authProvider.level == 'admin') {
    Navigator.pushReplacementNamed(context, '/admin');
  } else if (authProvider.level == 'tendik') {
    Navigator.pushReplacementNamed(context, '/tendik');
  } else {
    // Handle other roles or unexpected cases
    print('Unknown user role');
  }
}
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selamat Datang, ${authProvider.username}!'),
            Text('Kamu Login Sebagai ${authProvider.level}.'),
            ElevatedButton(
              onPressed: () {
                authProvider.logoutUser();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                redirectToDashboard(context, authProvider);
              },
              child: Text('Buka Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
