import 'package:hive/hive.dart';

part 'child.g.dart';

@HiveType(typeId: 0)
class Child extends HiveObject {
  @HiveField(0)
  String id; // uuid

  @HiveField(1)
  String name;

  Child({required this.id, required this.name});
}
