import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/models/citizen_login_model.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/api_services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with SingleTickerProviderStateMixin {
  bool _loading = false;
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  Widget _buildWidget() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: kToolbarHeight * 0.7,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
            const SizedBox(height: 20),
            TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.blue[700],
              tabs: const [
                Tab(
                  text: 'Citizen',
                ),
                Tab(
                  text: 'Company',
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            SizedBox(
                height: 400,
                child: TabBarView(controller: _tabController, children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      TextFormField(
                        validator: (value) {
                          String pattern =
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                          RegExp regExp = RegExp(pattern);

                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          } else if (!regExp.hasMatch(value.trim())) {
                            return 'Invalid email address';
                          }

                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Email",
                          floatingLabelStyle: const TextStyle(
                              height: 4,
                              color: Color.fromARGB(255, 32, 156, 223)),
                          filled: true,
                          fillColor: Colors.grey[300],
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          var minLength = 5;

                          if (value == null || value.trim().isEmpty) {
                            return 'This field is required';
                          } else if (value.trim().length < minLength) {
                            return "Password should have minimum 5 characters";
                          } else {
                            return null;
                          }
                        },
                        controller: _passwordController,
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none,
                            ),
                            labelText: "Password",
                            floatingLabelStyle: const TextStyle(
                                height: 4,
                                color: Color.fromARGB(255, 32, 156, 223)),
                            filled: true,
                            fillColor: Colors.grey[300],
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            try {
                              setState(() {
                                _loading = true;
                              });
                              CitizenRequestLogin model = CitizenRequestLogin(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim());

                              APIService.citizenLogin(model).then((response) {
                                setState(() {
                                  _loading = false;
                                });
                                if (response) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    homeRoute,
                                    (route) => false,
                                  );
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Invalid username / password',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 14.0);
                                }
                              });
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: 'Error signing in',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.grey,
                                  textColor: Colors.white,
                                  fontSize: 14.0);
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          child: const Center(
                              child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                citizenRegister,
                                (route) => false,
                              ),
                          child: const Text(
                            'New here? Register',
                          )),
                    ],
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(20.0),
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none,
                          ),
                          labelText: "Email",
                          floatingLabelStyle: const TextStyle(
                              height: 4,
                              color: Color.fromARGB(255, 32, 156, 223)),
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
                              height: 4,
                              color: Color.fromARGB(255, 32, 156, 223)),
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
                          // if (_formKey.currentState!.validate()) {
                          //   _formKey.currentState!.save();

                          //   try {
                          //     _login(_emailController.text.trim(),
                          //         _passwordController.text.trim());

                          //     Navigator.of(context).pushNamedAndRemoveUntil(
                          //       homeRoute,
                          //       (route) => false,
                          //     );
                          //   } catch (e) {
                          //     Fluttertoast.showToast(
                          //         msg: 'Error signing in',
                          //         toastLength: Toast.LENGTH_SHORT,
                          //         gravity: ToastGravity.BOTTOM,
                          //         timeInSecForIosWeb: 1,
                          //         backgroundColor: Colors.grey,
                          //         textColor: Colors.white,
                          //         fontSize: 14.0);
                          //   }
                          // }
                        },
                        child: Container(
                          height: 40,
                          child: const Center(
                              child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                            color: Colors.blue[700],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(
                          companyRegister,
                          (route) => false,
                        ),
                        child: const Text(
                          'New here? Register',
                        ),
                      ),
                    ],
                  )
                ])),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
      child: _buildWidget(),
      inAsyncCall: _loading,
    ));
  }
}
