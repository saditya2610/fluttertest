// Import statements
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth_provider.dart';
import 'Admin/AdminScreen.dart';
import 'Tendik/TendikScreen.dart';
import 'LoginScreen.dart';
import 'BottomBarScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        title: 'Flutter Dashboard Test Aing',
        theme: ThemeData(
          fontFamily: "Poppins",
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyApp(),
        routes: {
          '/admin': (context) => const AdminScreen(),
          '/tendik': (context) => const TendikScreen(),
          '/login': (context) => const LoginScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          '/grafik': (context) => const GrafikScreen(),
          '/jam_absensi': (context) => const JamAbsensiScreen(),
          '/kalender': (context) => const KalenderScreen(),
          '/profil': (context) => const ProfilScreen(),
          '/dashboard_details': (context) => const DashboardDetailsScreen(),
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return authProvider.isUserLoggedIn ? const BottomBarScreen() : const LoginScreen();
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

   Widget _buildCard(BuildContext context, String title, IconData icon, bool isAdmin) {
    final authProvider = Provider.of<AuthProvider>(context);

    if ((isAdmin && authProvider.isAdmin) || (!isAdmin && !authProvider.isAdmin)) {
      return Card(
        elevation: 5.0,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/dashboard_details', arguments: title);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50.0,
                color: Colors.blue,
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      // Return an empty container if the card is not applicable for the user's role
      return Container();
    }
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(icon, color: const Color.fromARGB(255, 19, 19, 19)),
      title: Text(title, style: const TextStyle(color: Color.fromARGB(255, 23, 23, 23))),
      onTap: () {
        Navigator.of(context, rootNavigator: true).pop(); // Safe pop
        Navigator.pushNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UNIVRABSDM', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 203, 41, 1),
              ),
              child: Text(
                'Dashboard Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerItem(context, 'Beranda', Icons.home, '/dashboard'),
            if (authProvider.level == 'admin') // Show only for admin level
              _buildDrawerItem(context, 'Dashboard', Icons.dashboard, '/dashboard'),
            if (authProvider.level == 'admin') // Show only for admin level
              _buildDrawerItem(context, 'Data Absen', Icons.graphic_eq, '/data_absen'),
            if (authProvider.level == 'admin') // Show only for admin level
              _buildDrawerItem(context, 'Manajemen User', Icons.supervised_user_circle, '/manajemen_user'),
            if (authProvider.level == 'admin') // Show only for admin level
              _buildDrawerItem(context, 'Data Karyawan', Icons.people, '/data_karyawan'),
            if (authProvider.level != 'admin') // Show only for non-admin levels
              _buildDrawerItem(context, 'Jam Absensi', Icons.access_alarms_outlined, '/jam_absensi'),
            if (authProvider.level != 'admin') // Show only for non-admin levels
              _buildDrawerItem(context, 'Profil', Icons.person, '/profil'),
            if (authProvider.level != 'admin') // Show only for non-admin levels
              _buildDrawerItem(context, 'Kalender', Icons.calendar_today, '/kalender'),
            _buildDrawerItem(context, 'Login', Icons.login, '/login'),
            if (authProvider.level == 'admin') // Show only for admin level
              _buildDrawerItem(context, 'Keluar', Icons.exit_to_app, '/keluar'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: const DecorationImage(
            image: AssetImage('assets/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 8.0,
          children: <Widget>[
            _buildCard(context, 'Dashboard', Icons.dashboard, true),
            _buildCard(context, 'Data Absen', Icons.graphic_eq, true),
            _buildCard(context, 'Manajemen User', Icons.supervised_user_circle, true),
            _buildCard(context, 'Data Karyawan', Icons.people, true),
            _buildCard(context, 'Jam Absensi', Icons.access_alarms_outlined, false),
            _buildCard(context, 'Profil', Icons.person, false),
            _buildCard(context, 'Kalender', Icons.calendar_today, false),
          ],
        ),
      ),
    );
  }
}

  Widget _buildAdminCard(BuildContext context, String title, IconData icon) {
    // Customize cards for Admin role
    return Card(
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/dashboard_details', arguments: title);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultCard(BuildContext context, String title, IconData icon) {
    // Default card for unknown user roles
    return Card(
      elevation: 5.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/dashboard_details', arguments: title);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 50.0,
              color: Colors.blue,
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

class DashboardDetailsScreen extends StatelessWidget {
  const DashboardDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: const DecorationImage(
            image: AssetImage('assets/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text('Details for $title', style: const TextStyle(color: Color.fromARGB(255, 5, 5, 5))),
        ),
      ),
    );
  }
}


class GrafikScreen extends StatelessWidget {
  const GrafikScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Absen', style: TextStyle(color:Colors.white)),
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: const DecorationImage(
            image: AssetImage('assets/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text('Data Absen', style: TextStyle(color: Color.fromARGB(255, 14, 14, 14))),
        ),
      ),
    );
  }
}

class KalenderScreen extends StatelessWidget {
  const KalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalender', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: const DecorationImage(
            image: AssetImage('assets/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text('Kalender Screen', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        ),
      ),
    );
  }
}


class ProfilScreen extends StatelessWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color:Colors.white)),
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: const DecorationImage(
            image: AssetImage('assets/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text('Profil Screen', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
        ),
      ),
    );
  }
}

class JamAbsensiScreen extends StatelessWidget {
  const JamAbsensiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 189, 2, 2),
        title: const Text('Jam Absensi', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: const DecorationImage(
            image: AssetImage('assets/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: OutlinedButton(
              onPressed: () {
                // Handle button tap
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color.fromARGB(255, 247, 2, 2), width: 2.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text(
                'Jam Absensi Screen',
                style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 18.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


