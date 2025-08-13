import 'package:hive/hive.dart';
import 'hadith_model.dart';

@HiveType(typeId: 2)
class Book extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String author;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final List<Hadith> hadiths;

  Book({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.createdAt,
    required this.hadiths,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final hadithList = <Hadith>[];
    if (json['hadiths'] != null && json['hadiths'] is List) {
      for (final h in json['hadiths']) {
        hadithList.add(Hadith.fromJson(Map<String, dynamic>.from(h)));
      }
    }

    return Book(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      author: json['author'] as String? ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      hadiths: hadithList,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'author': author,
        'created_at': createdAt.toIso8601String(),
        'hadiths': hadiths.map((h) => h.toJson()).toList(),
      };
}
