import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/company/citizen_sign_up.dart';
import 'package:mobile/home.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/shared_services.dart';
import 'package:mobile/sign_in.dart';
import 'package:mobile/citizen/citizen_sign_up.dart';

Widget _defaultHome = const CitizenSignUpPage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();

  if (_result) {
    _defaultHome = const HomePage();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SLBFE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _defaultHome,
        loginRoute: (context) => const SignIn(),
        citizenRegister: (context) => const CitizenSignUpPage(),
        companyRegister: (context) => const CompanySignUpPage(),
        homeRoute: (context) => const HomePage()
      },
    );
  }
}

// class AuthenticationWrapper extends StatelessWidget {
//   const AuthenticationWrapper({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final LocalStorage storage = LocalStorage('localstorage');
//     final isLogged = json.decode(storage.getItem('profile'));

//     print(isLogged);

//     return const Scaffold(
//       body: Center(child: Text('auth')),
//     );
//   }
// }
