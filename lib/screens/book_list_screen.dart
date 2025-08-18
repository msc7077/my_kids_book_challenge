import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/book.dart';
import '../models/chapter.dart';
import 'package:uuid/uuid.dart';

class BookListScreen extends StatefulWidget {
  final Chapter chapter;
  const BookListScreen({Key? key, required this.chapter}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Box<Book> bookBox;
  final TextEditingController _bookTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bookBox = Hive.box<Book>('books');
  }

  void _addBook() {
    if (_bookTitleController.text.isEmpty) return;
    final book = Book(
      id: const Uuid().v4(),
      chapterId: widget.chapter.id,
      title: _bookTitleController.text,
      imagePath: '',
    );
    bookBox.add(book);
    _bookTitleController.clear();
    setState(() {});
  }

  void _toggleComplete(Book book) {
    book.isCompleted = !book.isCompleted;
    book.save();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final books = bookBox.values
        .where((b) => b.chapterId == widget.chapter.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('${widget.chapter.title}의 책 목록')),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            trailing: IconButton(
              icon: Icon(book.isCompleted ? Icons.star : Icons.star_border),
              onPressed: () => _toggleComplete(book),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('책 추가'),
                content: TextField(
                  controller: _bookTitleController,
                  decoration: const InputDecoration(hintText: '책 제목'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _addBook();
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
