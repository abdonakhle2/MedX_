import 'dart:io';

class Documents {
  final String doc_id;
  final String title;
  final String description;
  final File file;
  Documents({
    required this.doc_id,
    required this.title,
    required this.description,
    required this.file,
  });
  factory Documents.fromJson(Map<String, dynamic> json) {
    return Documents(
      doc_id: json['doc_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      file: File(json['file']?.toString() ?? ''),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'doc_id': doc_id,
      'title': title,
      'description': description,
      'file': file.path,
    };
  }
}
