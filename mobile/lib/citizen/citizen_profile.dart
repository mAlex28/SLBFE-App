import 'package:flutter/material.dart';

class CitizenProfilePage extends StatefulWidget {
  const CitizenProfilePage({Key? key}) : super(key: key);

  @override
  State<CitizenProfilePage> createState() => _CitizenProfilePageState();
}

class _CitizenProfilePageState extends State<CitizenProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
        child: Column(
          children: [Text('cv')],
        ),
      ),
    );
  }
}
