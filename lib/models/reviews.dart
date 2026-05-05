class Reviews {
  final int id;
  final int user_id;
  final int appointments_id;
  final double rating;
  final String comment;
  Reviews({
    required this.id,
    required this.user_id,
    required this.appointments_id,
    required this.rating,
    required this.comment,
  });
}
