class ReviewModel {
  final String id;
  final String name;
  final String email;
  final String body;
  final double rating;
  final DateTime createdAt;

  ReviewModel({
    required this.id,
    required this.name,
    required this.email,
    required this.body,
    required this.rating,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'body': body,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      body: json['body'],
      rating: json['rating'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
