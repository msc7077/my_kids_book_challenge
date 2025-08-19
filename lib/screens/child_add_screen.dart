import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/child.dart';

class ChildAddScreen extends StatefulWidget {
  const ChildAddScreen({super.key});

  @override
  State<ChildAddScreen> createState() => _ChildAddScreenState();
}

class _ChildAddScreenState extends State<ChildAddScreen> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("자녀 추가")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "이름"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = _nameController.text.trim();

                if (name.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text("이름을 입력하세요")));
                  return;
                }

                final id = DateTime.now().millisecondsSinceEpoch.toString();
                final box = Hive.box<Child>('children');
                await box.add(Child(id: id, name: name));

                Navigator.pop(context); // 등록 후 부모 홈으로 돌아감
              },
              child: const Text("등록"),
            ),
          ],
        ),
      ),
    );
  }
}
