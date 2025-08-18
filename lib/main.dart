import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_kids_book_challenge/models/book.dart';
import 'package:my_kids_book_challenge/models/chapter.dart';
import 'package:my_kids_book_challenge/screens/chapter_list_screen.dart';
import 'package:uuid/uuid.dart';
import 'models/child.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.deleteBoxFromDisk('children');
  await Hive.deleteBoxFromDisk('chapters');
  await Hive.deleteBoxFromDisk('books');
  Hive.registerAdapter(ChildAdapter());
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(BookAdapter());

  await Hive.openBox<Child>('children');
  await Hive.openBox<Chapter>('chapters');
  await Hive.openBox<Book>('books');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ChildListScreen());
  }
}

class ChildListScreen extends StatefulWidget {
  const ChildListScreen({Key? key}) : super(key: key);

  @override
  State<ChildListScreen> createState() => _ChildListScreenState();
}

class _ChildListScreenState extends State<ChildListScreen> {
  late Box<Child> childBox;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    childBox = Hive.box<Child>('children');
  }

  void _addChild() {
    if (_nameController.text.isEmpty) return;
    final child = Child(id: const Uuid().v4(), name: _nameController.text);
    childBox.add(child);
    _nameController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final children = childBox.values.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('자녀 선택')),
      body: ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          final child = children[index];
          return ListTile(
            title: Text(child.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChapterListScreen(child: child),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('자녀 추가'),
                content: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: '이름 입력'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _addChild();
                      Navigator.pop(context);
                    },
                    child: const Text('등록'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
