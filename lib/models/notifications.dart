class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String? readAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.readAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      readAt: json['read_at'],
    );
  }
}
