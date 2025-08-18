import 'package:hive/hive.dart';

part 'book.g.dart';

@HiveType(typeId: 2)
class Book extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String chapterId; // 어떤 챕터의 책인지 연결

  @HiveField(2)
  String title;

  @HiveField(3)
  String imagePath; // 사진 경로

  @HiveField(4)
  bool isCompleted;

  Book({
    required this.id,
    required this.chapterId,
    required this.title,
    required this.imagePath,
    this.isCompleted = false,
  });
}
