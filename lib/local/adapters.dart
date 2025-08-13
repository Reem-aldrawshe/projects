// lib/data/local/adapters.dart
import 'package:hive/hive.dart';
import '../models/hadith_model.dart';
import '../models/book_model.dart';

class HadithAdapter extends TypeAdapter<Hadith> {
  @override
  final int typeId = 1;

  @override
  Hadith read(BinaryReader reader) {
    final n = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < n; i++) {
      final key = reader.readByte();
      fields[key] = reader.read();
    }
    return Hadith(
      id: fields[0] as int,
      title: fields[1] as String,
      content: fields[2] as String,
      raawi: fields[3] as String,
      bookId: fields[4] as int,
      createdAt: DateTime.parse(fields[5] as String),
    );
  }

  @override
  void write(BinaryWriter writer, Hadith obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.content)
      ..writeByte(3)
      ..write(obj.raawi)
      ..writeByte(4)
      ..write(obj.bookId)
      ..writeByte(5)
      ..write(obj.createdAt.toIso8601String());
  }
}

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 2;

  @override
  Book read(BinaryReader reader) {
    final n = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < n; i++) {
      final key = reader.readByte();
      fields[key] = reader.read();
    }
    final hadithsRaw = fields[5] as List<dynamic>? ?? [];
    final hadiths = hadithsRaw.cast<Hadith>();
    return Book(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      author: fields[3] as String,
      createdAt: DateTime.parse(fields[4] as String),
      hadiths: hadiths,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.createdAt.toIso8601String())
      ..writeByte(5)
      ..write(obj.hadiths);
  }
}
