class Reviews {
  final String id;
  final String user_id;
  final String appointments_id;
  final double rating;
  final String comment;
  Reviews({
    required this.id,
    required this.user_id,
    required this.appointments_id,
    required this.rating,
    required this.comment,
  });
  factory Reviews.fromJson(Map<String, dynamic> json) {
    return Reviews(
      id: json['id']?.toString() ?? '',
      user_id: json['user_id']?.toString() ?? '',
      appointments_id: json['appointments_id']?.toString() ?? '',
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      comment: json['comment']?.toString() ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': user_id,
      'appointments_id': appointments_id,
      'rating': rating,
      'comment': comment,
    };
  }
}
