class Rating {
  final double rating;

  Rating({required this.rating});

  Map<String, dynamic> toJson() {
    return {'rating': rating};
  }

  factory Rating.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return Rating(rating: 0.0);
    }

    return Rating(
      rating: json['rating'] != null
          ? double.tryParse(json['rating'].toString()) ?? 0.0
          : 0.0,
    );
  }
}
