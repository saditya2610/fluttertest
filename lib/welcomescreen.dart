import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoginScreen.dart';
import 'package:flutter_application_1/main.dart';
import 'BottomBarScreen.dart';

class WelcomeScreen extends StatelessWidget {
  final String username;
  final String level;

  WelcomeScreen(this.username, this.level);

void main() {
  runApp(
MaterialApp(
      title: 'Flutter Dashboard Test Aing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  const BottomBarScreen() ,
      routes: {
        '/dashboard': (context) => const DashboardDetailsScreen(),
        '/grafik': (context) => const GrafikScreen(),
        '/jam_absensi': (context) => const JamAbsensiScreen(),
        '/kalender': (context) => const KalenderScreen(),
        '/profil': (context) => const ProfilScreen(),
        '/dashboard_details': (context) => const DashboardDetailsScreen(),
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        title: Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Selamat Datang, $username!'),
            Text('Kamu Login Sebagai $level.'),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context)=> LoginScreen()
                    ),
                  ); // Close WelcomeScreen
              },
              child: Text('Logout'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
              child: Text('Buka Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
