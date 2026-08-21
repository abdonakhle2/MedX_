class User {
  final int? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  String? gender;
  DateTime? birthdate;
  String? address;
  dynamic idPassport;
  String? password;
  String? confirmPassword;
  String? created_at;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.gender,
    this.birthdate,
    this.address,
    this.idPassport,
    this.password,
    this.confirmPassword,
    this.created_at,
  });

  /// Full name getter
  String? get name {
    final parts = [
      firstName,
      lastName,
    ].where((p) => p != null && p.trim().isNotEmpty).toList();
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
    id: 502,
    firstName: 'John',
    lastName: 'Doe',
    phoneNumber: '234567890298123',
    email: 'JohnDoe@gmail.com',
    gender: 'Female',
    birthdate: DateTime(1992, 10, 24),
    address: '722 Marble Arch, West District, London, UK',
    idPassport: '123456789',
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

  /// 👈 تم تعديل المفاتيح لكي تطابق استجابة الـ Backend بالكامل
  factory User.fromJson(Map<String, dynamic> json) {
    print("--- User.fromJson ---");
    print("Raw id_passport from JSON: ${json['id_passport']}");
    return User(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,
      firstName: json['first_name']?.toString() ?? '',
      lastName: json['last_name']?.toString() ?? '',
      phoneNumber: json['phone_number']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      birthdate:
          DateTime.tryParse(json['birthdate']?.toString() ?? '') ??
          DateTime.now(),
      address: json['address']?.toString() ?? '',
      idPassport: json['id_passport'] ?? '',
      password: json['password']?.toString() ?? '',
      confirmPassword: json['password_confirmation']?.toString() ?? '',
      created_at: json['created_at']?.toString() ?? '',
    );
  }

  /// 👈 تم ضبط تحويل التاريخ إلى صيغة ISO String متوافقة مع الـ JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'email': email,
      'gender': gender,
      // تحويل التاريخ لصيغة YYYY-MM-DD لضمان القبول في السيرفر
      'birthdate': birthdate != null
          ? "${birthdate!.year}-${birthdate!.month.toString().padLeft(2, '0')}-${birthdate!.day.toString().padLeft(2, '0')}"
          : null,
      'address': address,
      'id_passport': idPassport,
      if (password != null) 'password': password,
      if (confirmPassword != null) 'password_confirmation': confirmPassword,
      'created_at': created_at,
    };
  }
}
