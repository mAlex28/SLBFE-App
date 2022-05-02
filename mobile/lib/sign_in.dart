import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _loading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(String email, String password) async {
    try {
      setState(() {
        _loading = true;
      });
      Response response = await post(
          Uri.parse('https://slbfe-api-app.herokuapp.com/citizen/signin'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
      } else {
        Fluttertoast.showToast(
            msg: 'Error signing up',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print(e.toString());
    }
  }

  Widget _buildWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              labelText: "Email",
              floatingLabelStyle: const TextStyle(
                  height: 4, color: Color.fromARGB(255, 32, 156, 223)),
              filled: true,
              fillColor: Colors.grey[300],
              prefixIcon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none,
              ),
              labelText: "Password",
              floatingLabelStyle: const TextStyle(
                  height: 4, color: Color.fromARGB(255, 32, 156, 223)),
              filled: true,
              fillColor: Colors.grey[300],
              prefixIcon: const Icon(Icons.password),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              _login(_emailController.text.trim(),
                  _passwordController.text.trim());
            },
            child: Container(
              height: 40,
              child: const Center(
                  child: Text(
                'Sign up',
                style: TextStyle(color: Colors.white),
              )),
              decoration: BoxDecoration(
                color: Colors.blue[700],
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),
        body: ModalProgressHUD(
          child: _buildWidget(),
          inAsyncCall: _loading,
        ));
  }
}
