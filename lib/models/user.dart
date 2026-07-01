class User {
  String? firstName;
  String? lastName;
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
    this.firstName,
    this.lastName,
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

  /// Full name getter for backwards compatibility
  String? get name {
    final parts = [
      firstName,
      lastName,
    ].where((p) => p != null && p.isNotEmpty).toList();
    return parts.isEmpty ? null : parts.join(' ');
  }

  set name(String? value) {
    if (value == null || value.trim().isEmpty) {
      firstName = null;
      lastName = null;
      return;
    }
    final parts = value.trim().split(' ');
    firstName = parts.first;
    lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
  }

  static User currentUser = User(
    firstName: 'John',
    lastName: 'Doe',
    phone_number: 999999999,
    email: 'JohnDoe@gmail.com',
    gender: 'Female',
    birthdate: DateTime(1992, 10, 24),
    address: '722 Marble Arch, West District, London, UK',
    id_passport: 123456789,
    Is_verified: true,
  );

  int get age {
    if (birthdate == null) return 0;
    final now = DateTime.now();
    int age = now.year - birthdate!.year;
    if (now.month < birthdate!.month ||
        (now.month == birthdate!.month && now.day < birthdate!.day)) {
      age--;
    }
    return age;
  }

  String get formattedBirthdate {
    if (birthdate == null) return '';
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return "${months[birthdate!.month - 1]} ${birthdate!.day}, ${birthdate!.year}";
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName']?.toString(),
      lastName: json['lastName']?.toString(),
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
      'firstName': firstName,
      'lastName': lastName,
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
