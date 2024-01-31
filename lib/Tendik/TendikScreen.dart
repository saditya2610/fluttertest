import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_provider.dart';
import 'package:provider/provider.dart';

class TendikScreen extends StatelessWidget {
  const TendikScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tendik Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome, Tendik!'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                authProvider.logoutUser();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}