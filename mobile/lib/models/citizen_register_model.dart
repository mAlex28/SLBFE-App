import 'dart:convert';

CitizenResponseRegister citizenResponseRegister(String str) =>
    CitizenResponseRegister.fromJson(json.decode(str));

class CitizenRequestRegister {
  CitizenRequestRegister({
    required this.nic,
    required this.profilePic,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.description,
    required this.contact,
    required this.address,
    required this.postalCode,
    required this.city,
    required this.province,
    required this.latitude,
    required this.longitude,
    required this.profession,
    required this.email,
    required this.qualifications,
    required this.password,
    required this.birthCertificate,
    required this.cv,
    required this.passport,
    required this.confirmPassword,
  });
  late final String nic;
  late final String profilePic;
  late final String firstName;
  late final String lastName;
  late final String age;
  late final String description;
  late final String contact;
  late final String address;
  late final String postalCode;
  late final String city;
  late final String province;
  late final String latitude;
  late final String longitude;
  late final String profession;
  late final String email;
  late final List<String> qualifications;
  late final String password;
  late final String birthCertificate;
  late final String cv;
  late final String passport;
  late final String confirmPassword;

  CitizenRequestRegister.fromJson(Map<String, dynamic> json) {
    nic = json['nic'];
    profilePic = json['profilePic'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    description = json['description'];
    contact = json['contact'];
    address = json['address'];
    postalCode = json['postalCode'];
    city = json['city'];
    province = json['province'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    profession = json['profession'];
    email = json['email'];
    qualifications = List.castFrom<dynamic, String>(json['qualifications']);
    password = json['password'];
    birthCertificate = json['birthCertificate'];
    cv = json['cv'];
    passport = json['passport'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nic'] = nic;
    _data['profilePic'] = profilePic;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['age'] = age;
    _data['description'] = description;
    _data['contact'] = contact;
    _data['address'] = address;
    _data['postalCode'] = postalCode;
    _data['city'] = city;
    _data['province'] = province;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['profession'] = profession;
    _data['email'] = email;
    _data['qualifications'] = qualifications;
    _data['password'] = password;
    _data['birthCertificate'] = birthCertificate;
    _data['cv'] = cv;
    _data['passport'] = passport;
    _data['confirmPassword'] = confirmPassword;
    return _data;
  }
}

class CitizenResponseRegister {
  CitizenResponseRegister({
    required this.result,
    required this.token,
  });
  late final Result? result;
  late final String token;

  CitizenResponseRegister.fromJson(Map<String, dynamic> json) {
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
    required this.location,
    required this.profession,
    required this.email,
    required this.qualifications,
    required this.password,
    required this.birthCertificate,
    required this.cv,
    required this.passport,
    required this.isVerified,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
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
  late final Location location;
  late final String profession;
  late final String email;
  late final List<String> qualifications;
  late final String password;
  late final String birthCertificate;
  late final String cv;
  late final String passport;
  late final bool isVerified;
  late final String id;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Result.fromJson(Map<String, dynamic> json) {
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
    location = Location.fromJson(json['location']);
    profession = json['profession'];
    email = json['email'];
    qualifications = List.castFrom<dynamic, String>(json['qualifications']);
    password = json['password'];
    birthCertificate = json['birthCertificate'];
    cv = json['cv'];
    passport = json['passport'];
    isVerified = json['isVerified'];
    id = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
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
    _data['location'] = location.toJson();
    _data['profession'] = profession;
    _data['email'] = email;
    _data['qualifications'] = qualifications;
    _data['password'] = password;
    _data['birthCertificate'] = birthCertificate;
    _data['cv'] = cv;
    _data['passport'] = passport;
    _data['isVerified'] = isVerified;
    _data['_id'] = id;
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
