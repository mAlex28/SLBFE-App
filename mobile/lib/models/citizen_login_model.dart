import 'dart:convert';

CitizenResponseLogin citizenResponseLogin(String str) =>
    CitizenResponseLogin.fromJson(json.decode(str));

class CitizenRequestLogin {
  CitizenRequestLogin({
    required this.email,
    required this.password,
  });
  late final String email;
  late final String password;

  CitizenRequestLogin.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['email'] = email;
    _data['password'] = password;
    return _data;
  }
}

class CitizenResponseLogin {
  CitizenResponseLogin({
    required this.result,
    required this.token,
  });
  late final Result result;
  late final String token;

  CitizenResponseLogin.fromJson(Map<String, dynamic> json) {
    result = Result.fromJson(json['result']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Result {
  Result({
    required this.location,
    required this.id,
    required this.nic,
    required this.profilePic,
    required this.name,
    required this.age,
    required this.description,
    required this.contact,
    required this.address,
    required this.postalCode,
    required this.city,
    required this.province,
    required this.profession,
    required this.email,
    required this.qualifications,
    required this.password,
    required this.birthCertificate,
    required this.cv,
    required this.passport,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final Location location;
  late final String id;
  late final String nic;
  late final String profilePic;
  late final String name;
  late final String age;
  late final String description;
  late final String contact;
  late final String address;
  late final String postalCode;
  late final String city;
  late final String province;
  late final String profession;
  late final String email;
  late final List<String> qualifications;
  late final String password;
  late final String birthCertificate;
  late final String cv;
  late final String passport;
  late final bool isVerified;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Result.fromJson(Map<String, dynamic> json) {
    location = Location.fromJson(json['location']);
    id = json['_id'];
    nic = json['nic'];
    profilePic = json['profilePic'];
    name = json['name'];
    age = json['age'];
    description = json['description'];
    contact = json['contact'];
    address = json['address'];
    postalCode = json['postalCode'];
    city = json['city'];
    province = json['province'];
    profession = json['profession'];
    email = json['email'];
    qualifications = List.castFrom<dynamic, String>(json['qualifications']);
    password = json['password'];
    birthCertificate = json['birthCertificate'];
    cv = json['cv'];
    passport = json['passport'];
    isVerified = json['isVerified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['location'] = location.toJson();
    _data['_id'] = id;
    _data['nic'] = nic;
    _data['profilePic'] = profilePic;
    _data['name'] = name;
    _data['age'] = age;
    _data['description'] = description;
    _data['contact'] = contact;
    _data['address'] = address;
    _data['postalCode'] = postalCode;
    _data['city'] = city;
    _data['province'] = province;
    _data['profession'] = profession;
    _data['email'] = email;
    _data['qualifications'] = qualifications;
    _data['password'] = password;
    _data['birthCertificate'] = birthCertificate;
    _data['cv'] = cv;
    _data['passport'] = passport;
    _data['isVerified'] = isVerified;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });
  late final String latitude;
  late final String longitude;

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}
