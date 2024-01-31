import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/welcomescreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final apiUrl = 'http://10.223.43.205/buku/php/login.php'; // Update with your login API endpoint

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = jsonDecode(response.body);

        if (data != null) {
          if (data['status'] == 'success') {
            print('Login Berhasil');
            showSnackBar(context, 'Login Berhasil');

            // Access the AuthProvider and update the login state
            Provider.of<AuthProvider>(context, listen: false)
                .loginUser(data['data']['username'], data['data']['level']);

            // Redirect to the appropriate screen based on user role
            _redirectToScreen(context, data['data']['level']);
          } else {
            print('Login Gagal. Message: ${data['message']}');
            showSnackBar(context, 'Login Gagal. ${data['message']}');
          }
        } else {
          print('Invalid JSON response');
          showSnackBar(context, 'An error occurred during login.');
        }
      } else {
        print('API request failed. Status: ${response.statusCode}, Message: ${response.body}');
        showSnackBar(context, 'Cek Username dan Password Anda.');
      }
    } catch (e) {
      print('Error: $e');
      showSnackBar(context, 'An error occurred during login.');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _redirectToScreen(BuildContext context, String userRole) {
    // Redirect to the appropriate screen based on user role
    switch (userRole) {
      case 'admin':
        Navigator.pushReplacementNamed(context, '/admin');
        break;
      case 'tendik':
        Navigator.pushReplacementNamed(context, '/tendik');
        break;
      default:
        // Handle other roles or unexpected cases
        print('Tidak diketahui user role');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFB90202), Color(0xFFFF5722)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock, color: Colors.white),
              SizedBox(width: 8.0),
              Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white),
              onPressed: () {
                // Tambahkan aksi yang diinginkan saat tombol info ditekan
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/logo.jpg',
                      height: 100.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.3),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.black),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.3),
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    loginUser(context);
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(height: 8.0), // Spacer
                TextButton(
                  onPressed: () {
                    // Tambahkan aksi yang diinginkan saat tombol "Lupa Password" ditekan
                    showSnackBar(context, 'Implementasi untuk lupa password belum ditambahkan.');
                  },
                  child: const Text('Lupa Password', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
