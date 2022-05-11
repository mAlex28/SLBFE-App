import 'package:flutter/material.dart';
import 'package:mobile/citizen/citizen_profile.dart';
import 'package:mobile/company/company_sign_up.dart';
import 'package:mobile/company/company_home.dart';
import 'package:mobile/company/company_profile.dart';
import 'package:mobile/home.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/shared_services.dart';
import 'package:mobile/sign_in.dart';
import 'package:mobile/citizen/citizen_sign_up.dart';

Widget _defaultHome = const SignIn();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool _result = await SharedService.isLoggedIn();
  bool _cresult = await CompanySharedService.isLoggedIn();

  if (_result || _cresult) {
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
        homeRoute: (context) => const HomePage(),
        companyHomeRoute: (context) => const CompanyHomePage(),
        citizenProfileRoute: (context) => const CitizenProfilePage(),
        companyProfileRoute: (context) => const CompanyProfilePage()
      },
    );
  }
}
