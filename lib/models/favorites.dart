class Favorites {
  final String user_id;
  final String clinic_id;
  Favorites({required this.user_id, required this.clinic_id});
  factory Favorites.fromJson(Map<String, dynamic> json) {
    return Favorites(
      user_id: json['user_id']?.toString() ?? '',
      clinic_id: json['clinic_id']?.toString() ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'user_id': user_id, 'clinic_id': clinic_id};
  }
}
