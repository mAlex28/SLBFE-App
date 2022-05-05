import 'package:flutter/material.dart';

class CompanyProfilePage extends StatefulWidget {
  final dynamic citizen;

  const CompanyProfilePage({Key? key, this.citizen}) : super(key: key);

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
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
