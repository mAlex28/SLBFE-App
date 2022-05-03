import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/citizen_login_model.dart';
import 'package:mobile/models/citizen_register_model.dart';
import 'package:mobile/services/shared_services.dart';

class APIService {
  static var client = http.Client();

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

  static Future<CitizenResponseRegister> citizenRegister(
      CitizenRequestRegister model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http('http://192.168.1.29:5000', '/citizen/signup');

    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    return citizenResponseRegister(response.body);
  }

  static Future<String> getUsersProfile() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    // 'Authorization': 'Basic ${loginDetails!.token}'

    var url = Uri.http('192.168.1.29:5000', '/citizen', {'page': "1"});

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode != 404) {
      return response.body;
    } else {
      return "";
    }
  }
}
