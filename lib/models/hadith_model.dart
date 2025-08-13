import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class Hadith extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final String raawi;

  @HiveField(4)
  final int bookId;

  @HiveField(5)
  final DateTime createdAt;

  Hadith({
    required this.id,
    required this.title,
    required this.content,
    required this.raawi,
    required this.bookId,
    required this.createdAt,
  });

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      raawi: json['raawi'] as String? ?? '',
      bookId: json['book_id'] as int? ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'raawi': raawi,
        'book_id': bookId,
        'created_at': createdAt.toIso8601String(),
      };
}
