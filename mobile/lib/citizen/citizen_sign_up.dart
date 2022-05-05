import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/custom/multiselection_form_field.dart';
import 'package:mobile/models/citizen_register_model.dart';
import 'package:mobile/routes/routes.dart';
import 'package:mobile/services/api_services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:path_provider/path_provider.dart';

class CitizenSignUpPage extends StatefulWidget {
  const CitizenSignUpPage({Key? key}) : super(key: key);

  @override
  State<CitizenSignUpPage> createState() => _CitizenSignUpPageState();
}

class _CitizenSignUpPageState extends State<CitizenSignUpPage> {
  final LocalStorage storage = LocalStorage('localstorage');

  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  dynamic _qualifications = [];
  var profilePicture;
  var birthCertifictePhoto;
  var cvPhoto;
  var passportPhoto;

  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalcodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<Position> _getGeoLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  }

  _register(
    nic,
    profilePic,
    firstName,
    lastName,
    age,
    description,
    contact,
    address,
    postalCode,
    city,
    province,
    latitude,
    longitude,
    profession,
    email,
    qualifications,
    password,
    birthCertificate,
    cv,
    passport,
    confirmPassword,
  ) async {
    try {
      setState(() {
        _loading = true;
      });
      Response response = await post(
          Uri.parse('http://192.168.1.29:5000/citizen/signup'),
          body: {
            "nic": nic,
            "profilePic": profilePic,
            "firstName": firstName,
            "lastName": lastName,
            "age": age,
            "description": description,
            "contact": contact,
            "address": address,
            "postalCode": postalCode,
            "city": city,
            "province": province,
            "latitude": latitude,
            "longitude": longitude,
            "profession": profession,
            "email": email,
            "qualifications": qualifications,
            "password": password,
            "birthCertificate": birthCertificate,
            "cv": cv,
            "passport": passport,
            "confirmPassword": confirmPassword
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        storage.setItem('profile', data);
        print(storage);
      } else if (response.body == "User already exist") {
        Fluttertoast.showToast(
            msg: "User doesn't exist",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 14.0);
      } else {
        Fluttertoast.showToast(
            msg: 'Passwords does not match',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 14.0);
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
    setState(() {
      _loading = false;
    });
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
              controller: _nicController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "NIC (Ex: 197419202757)",
                  floatingLabelStyle: const TextStyle(
                      height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                  filled: true,
                  fillColor: Colors.grey[300],
                  prefixIcon: const Icon(Icons.credit_card)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value) => validate(value),
              controller: _firstNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "First Name",
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
              controller: _lastNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Last Name",
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
              keyboardType: TextInputType.number,
              controller: _ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Age",
                floatingLabelStyle: const TextStyle(
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.calendar_month),
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
              keyboardType: TextInputType.number,
              controller: _postalcodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Postal Code",
                floatingLabelStyle: const TextStyle(
                    height: 4, color: Color.fromARGB(255, 32, 156, 223)),
                filled: true,
                fillColor: Colors.grey[300],
                prefixIcon: const Icon(Icons.numbers),
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
                labelText: "Province",
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
              controller: _professionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide.none,
                ),
                labelText: "Profession (Ex: Software Engineer)",
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
              validator: (qualifications) => (qualifications?.length ?? 0) < 2
                  ? 'Please add at least 2 qualifications'
                  : null,
              onSaved: (qualifications) {
                _qualifications = qualifications!;
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
            TextButton(
                onPressed: () async {
                  final result =
                      await FilePicker.platform.pickFiles(type: FileType.image);
                  if (result == null) return;

                  PlatformFile file = result.files.first;
                  profilePicture = file;
                  print(file.bytes);
                  print(file.name);

                  final newFile = await saveFilePermanent(file);
                  print('from path: ${file.path}');
                  print('to path: ${newFile.path}');
                },
                child: const Text('Upload a profile picture')),
            Text('${profilePicture}'),
            TextButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'doc', 'png']);
                  if (result == null) return;

                  birthCertifictePhoto = result.files.first.bytes;
                },
                child: const Text('Upload the birth certificate')),
            Text('${profilePicture}'),
            TextButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'doc', 'png']);
                  if (result == null) return;

                  cvPhoto = result.files.first.bytes;
                },
                child: const Text('Upload your cv')),
            Text('${cvPhoto}'),
            TextButton(
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'doc', 'png']);
                  if (result == null) return;

                  passportPhoto = result.files.first.bytes;
                },
                child: const Text('Upload a passport photo')),
            Text('${passportPhoto}'),
            GestureDetector(
              onTap: () async {
                print(_qualifications);
                Position position = await _getGeoLocation();

                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  try {
                    setState(() {
                      _loading = true;
                    });

                    CitizenRequestRegister model = CitizenRequestRegister(
                        nic: _nicController.text.trim(),
                        profilePic: "",
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        age: _ageController.text.trim(),
                        description: _descriptionController.text.trim(),
                        contact: _contactController.text.trim(),
                        address: _addressController.text.trim(),
                        postalCode: _postalcodeController.text.trim(),
                        city: _cityController.text.trim(),
                        province: _provinceController.text.trim(),
                        latitude: position.latitude.toString(),
                        longitude: position.longitude.toString(),
                        profession: _professionController.text.trim(),
                        email: _emailController.text.trim(),
                        qualifications: _qualifications,
                        password: _passwordController.text.trim(),
                        birthCertificate: "",
                        cv: "",
                        passport: "",
                        confirmPassword:
                            _confirmPasswordController.text.trim());

                    APIService.citizenRegister(model).then((response) {
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

                    // _register(
                    //     _nicController.text.trim(),
                    //     "",
                    //     _firstNameController.text.trim(),
                    //     _lastNameController.text.trim(),
                    //     _ageController.text.trim(),
                    //     _descriptionController.text.trim(),
                    //     _contactController.text.trim(),
                    //     _addressController.text.trim(),
                    //     _postalcodeController.text.trim(),
                    //     _cityController.text.trim(),
                    //     _provinceController.text.trim(),
                    //     position.latitude,
                    //     position.longitude,
                    //     _professionController.text.trim(),
                    //     _emailController.text.trim(),
                    //     _qualifications,
                    //     _passwordController.text.trim(),
                    //     "birthCertificate",
                    //     "cv",
                    //     "passport",
                    //     _confirmPasswordController.text.trim());
                    // Navigator.of(context).pushNamedAndRemoveUntil(
                    //   homeRoute,
                    //   (route) => false,
                    // );
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

  Future<File> saveFilePermanent(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');

    return File(file.path!).copy(newFile.path);
  }
}
