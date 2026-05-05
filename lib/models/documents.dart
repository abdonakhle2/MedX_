import 'dart:io';

class Documents {
  final int doc_id;
  final String title;
  final String description;
  final File file;
  Documents({
    required this.doc_id,
    required this.title,
    required this.description,
    required this.file,
  });
}
