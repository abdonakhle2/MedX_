class User {
  String? name;
  int? phone_number;
  String? email;
  String? gender;
  DateTime? birthdate;
  String? address;
  int? id_passport;
  String? password;
  String? confirm_password;
  bool Is_verified;

  User({
    this.name,
    this.phone_number,
    this.email,
    this.gender,
    this.birthdate,
    this.address,
    this.id_passport,
    this.password,
    this.confirm_password,
    this.Is_verified = false,
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name']?.toString(),
      phone_number: int.tryParse(json['phone_number'].toString()),
      email: json['email']?.toString(),
      gender: json['gender']?.toString(),
      birthdate: json['birthdate'] != null
          ? DateTime.parse(json['birthdate'].toString())
          : null,
      address: json['address']?.toString(),
      id_passport: int.tryParse(json['id_passport'].toString()),
      password: json['password']?.toString(),
      confirm_password: json['confirm_password']?.toString(),
      Is_verified: json['Is_verified'] == true,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phone_number,
      'email': email,
      'gender': gender,
      'birthdate': birthdate,
      'address': address,
      'id_passport': id_passport,
      'password': password,
      'confirm_password': confirm_password,
      'Is_verified': Is_verified,
    };
  }
}
