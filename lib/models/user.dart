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
}
