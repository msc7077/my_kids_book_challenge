import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/chapter.dart';
import '../models/child.dart';
import 'book_list_screen.dart';
import 'package:uuid/uuid.dart';

class ChapterListScreen extends StatefulWidget {
  final Child child;
  const ChapterListScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<ChapterListScreen> createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  late Box<Chapter> chapterBox;
  final TextEditingController _chapterTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    chapterBox = Hive.box<Chapter>('chapters');
  }

  void _addChapter() {
    if (_chapterTitleController.text.isEmpty) return;
    final chapter = Chapter(
      id: const Uuid().v4(),
      childId: widget.child.id,
      title: _chapterTitleController.text,
    );
    chapterBox.add(chapter);
    _chapterTitleController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final chapters = chapterBox.values
        .where((c) => c.childId == widget.child.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('${widget.child.name}의 챕터')),
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];
          return ListTile(
            title: Text(chapter.title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookListScreen(chapter: chapter),
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
                title: const Text('챕터 추가'),
                content: TextField(
                  controller: _chapterTitleController,
                  decoration: const InputDecoration(hintText: '챕터 제목'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _addChapter();
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
