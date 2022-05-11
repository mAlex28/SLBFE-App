import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/custom/multiselection_form_field.dart';
import 'package:mobile/models/company_register_model.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/api_services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CompanySignUpPage extends StatefulWidget {
  const CompanySignUpPage({Key? key}) : super(key: key);

  @override
  State<CompanySignUpPage> createState() => _CompanySignUpPageState();
}

class _CompanySignUpPageState extends State<CompanySignUpPage> {
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  dynamic _fields = [];

  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  }

  Widget _buildWidget() {
    return SingleChildScrollView(
        child: Padding(
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
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) => validate(value),
              controller: _companyNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Company Name",
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
              validator: (value) => validate(value),
              keyboardType: TextInputType.phone,
              controller: _contactController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Contact",
                floatingLabelStyle: const TextStyle(
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.phone),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) => validate(value),
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Street Address",
                floatingLabelStyle: const TextStyle(
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.roundabout_left),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) => validate(value),
              controller: _cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "City",
                floatingLabelStyle: const TextStyle(
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.location_city),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) => validate(value),
              controller: _provinceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Province/State",
                floatingLabelStyle: const TextStyle(
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.location_city),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) => validate(value),
              controller: _countryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Country",
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
              validator: (value) => validate(value),
              controller: _websiteController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Website",
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
              keyboardType: TextInputType.multiline,
              validator: (value) => validate(value),
              controller: _descriptionController,
              minLines: 5,
              maxLines: null,
              maxLength: 1000,
              decoration: InputDecoration(
                hintText: "Add a description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                floatingLabelStyle: const TextStyle(
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyMultiSelectionFormField(
              validator: (fields) => (fields?.length ?? 0) < 2
                  ? 'Please add at least 2 fields'
                  : null,
              onSaved: (fields) {
                _fields = fields!;
              },
            ),
            const SizedBox(
              height: 20,
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
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) {
                var minLength = 5;
                if (value == null || value.trim().isEmpty) {
                  return "This field is required";
                } else if (value.trim().length < minLength) {
                  return "Password should have minimum 5 characters";
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.visiblePassword,
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
            TextFormField(
              validator: (value) {
                var minLength = 6;
                if (value == null || value.trim().isEmpty) {
                  return "This field is required";
                } else if (value.toString().trim() !=
                    _passwordController.text.trim()) {
                  return "Passwords does not match";
                } else {
                  return null;
                }
              },
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Confirm Password",
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
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    setState(() {
                      _loading = true;
                    });

                    CompanyRegisterRequest model = CompanyRegisterRequest(
                        companyName: _companyNameController.text.trim(),
                        description: _descriptionController.text.trim(),
                        contact: _contactController.text.trim(),
                        address: _addressController.text.trim(),
                        city: _cityController.text.trim(),
                        province: _provinceController.text.trim(),
                        country: _countryController.text.trim(),
                        email: _emailController.text.trim(),
                        companyFields: _fields,
                        password: _passwordController.text.trim(),
                        confirmPassword: _confirmPasswordController.text.trim(),
                        website: _websiteController.text.trim());

                    APIService.companyRegister(model).then((response) {
                      setState(() {
                        _loading = false;
                      });
                      if (response.result != null) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          homeRoute,
                          (route) => false,
                        );
                      } else {
                        Fluttertoast.showToast(
                            msg: 'Incomplete form',
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
                        msg: 'Error signing up',
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
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                )),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (route) => false,
                    ),
                child: const Text(
                  'Login',
                )),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: _buildWidget(),
        inAsyncCall: _loading,
      ),
    );
  }
}
