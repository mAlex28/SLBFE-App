import 'dart:convert';

CompanyRegisterResponse companyRegisterResponse(String str) =>
    CompanyRegisterResponse.fromJson(json.decode(str));

class CompanyRegisterRequest {
  CompanyRegisterRequest({
    required this.companyName,
    required this.description,
    required this.contact,
    required this.address,
    required this.city,
    required this.province,
    required this.country,
    required this.email,
    required this.password,
    required this.website,
    required this.companyFields,
    required this.confirmPassword,
  });
  late final String companyName;
  late final String description;
  late final String contact;
  late final String address;
  late final String city;
  late final String province;
  late final String country;
  late final String email;
  late final String password;
  late final String website;
  late final List<String> companyFields;
  late final String confirmPassword;

  CompanyRegisterRequest.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    description = json['description'];
    contact = json['contact'];
    address = json['address'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    email = json['email'];
    password = json['password'];
    website = json['webiste'];
    companyFields = List.castFrom<dynamic, String>(json['companyFields']);
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['companyName'] = companyName;
    _data['description'] = description;
    _data['contact'] = contact;
    _data['address'] = address;
    _data['city'] = city;
    _data['province'] = province;
    _data['country'] = country;
    _data['email'] = email;
    _data['password'] = password;
    _data['website'] = website;
    _data['companyFields'] = companyFields;
    _data['confirmPassword'] = confirmPassword;
    return _data;
  }
}

class CompanyRegisterResponse {
  CompanyRegisterResponse({
    required this.result,
    required this.token,
  });
  late final Result? result;
  late final String token;

  CompanyRegisterResponse.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result!.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Result {
  Result({
    required this.companyName,
    required this.description,
    required this.contact,
    required this.address,
    required this.city,
    required this.province,
    required this.country,
    required this.email,
    required this.password,
    required this.website,
    required this.companyFields,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final String companyName;
  late final String description;
  late final String contact;
  late final String address;
  late final String city;
  late final String province;
  late final String country;
  late final String email;
  late final String password;
  late final String website;
  late final List<String> companyFields;
  late final String id;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Result.fromJson(Map<String, dynamic> json) {
    companyName = json['companyName'];
    description = json['description'];
    contact = json['contact'];
    address = json['address'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    email = json['email'];
    password = json['password'];
    website = json['website'];
    companyFields = List.castFrom<dynamic, String>(json['companyFields']);
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['companyName'] = companyName;
    _data['description'] = description;
    _data['contact'] = contact;
    _data['address'] = address;
    _data['city'] = city;
    _data['province'] = province;
    _data['country'] = country;
    _data['email'] = email;
    _data['password'] = password;
    _data['website'] = website;
    _data['companyFields'] = companyFields;
    _data['_id'] = id;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}
