import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mobile/custom/multiselection_form_field.dart';
import 'package:mobile/routes/routes.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CitizenUserPage extends StatefulWidget {
  const CitizenUserPage({Key? key}) : super(key: key);

  @override
  State<CitizenUserPage> createState() => _CitizenUserPageState();
}

class _CitizenUserPageState extends State<CitizenUserPage> {
  final LocalStorage storage = LocalStorage('localstorage');

  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  dynamic _qualifications = [];

  final TextEditingController _nicController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _postalcodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

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
              autofocus: true,
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
            TextButton(
                onPressed: () async {
                  Position position = await _getGeoLocation();
                },
                child: const Text(
                  'Change location',
                )),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              child: Container(
                height: 40,
                child: const Center(
                    child: Text(
                  'Update Account',
                  style: TextStyle(color: Colors.white),
                )),
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Delete Account',
                  style: TextStyle(color: Colors.red),
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
