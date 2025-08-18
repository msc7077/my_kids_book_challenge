import 'package:hive/hive.dart';

part 'chapter.g.dart';

@HiveType(typeId: 1)
class Chapter extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String childId; // 어떤 아이의 챕터인지 연결

  @HiveField(2)
  String title;

  Chapter({required this.id, required this.childId, required this.title});
}
