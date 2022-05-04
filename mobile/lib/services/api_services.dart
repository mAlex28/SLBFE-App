import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/citizen_login_model.dart';
import 'package:mobile/models/citizen_register_model.dart';
import 'package:mobile/services/shared_services.dart';

class APIService {
  static var client = http.Client();

  /// Sign in the citizen with a JWT token
  static Future<bool> citizenLogin(CitizenRequestLogin model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http('192.168.1.29:5000', '/citizen/signin');

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(citizenResponseLogin(response.body));
      return true;
    } else {
      return false;
    }
  }

  /// Create a new citizen
  static Future<CitizenResponseRegister> citizenRegister(
      CitizenRequestRegister model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http('192.168.1.29:5000', '/citizen/signup');

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    return citizenResponseRegister(response.body);
  }

  /// Make a complain to the officers
  static Future makeComplains(email, complainTitle, complainText) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.token}'
    };

    final body = {
      "email": email,
      "complainTitle": complainTitle,
      "complainText": complainText,
    };

    var url = Uri.http('192.168.1.29:5000', '/citizen/complains');
    var response =
        await client.post(url, headers: requestHeaders, body: jsonEncode(body));

    if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg:
              'Successfully submitted the complain. Our team will be in touch soon',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 14.0);
    } else {
      Fluttertoast.showToast(
          msg: 'Error: Complaint node made.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }
}
