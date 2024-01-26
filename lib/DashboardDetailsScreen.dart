import 'package:flutter/material.dart';


class DashboardDetailsScreen extends StatelessWidget {
  final String title;

  const DashboardDetailsScreen(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 0, 0, 0.5),
          image: DecorationImage(
            image: AssetImage('assets/logo.jpg'), // Sesuaikan dengan nama gambar latar belakang Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text('Details for $title'),
        ),
      ),
    );
  }
}
