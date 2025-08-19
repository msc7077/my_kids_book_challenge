import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/child.dart';
import 'child_add_screen.dart';

class ParentHomeScreen extends StatelessWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final childrenBox = Hive.box<Child>('children');

    return Scaffold(
      appBar: AppBar(title: const Text("부모 홈")),
      body: ValueListenableBuilder(
        valueListenable: childrenBox.listenable(),
        builder: (context, Box<Child> box, _) {
          final children = box.values.toList();

          return Column(
            children: [
              Expanded(
                child: children.isEmpty
                    ? const Center(child: Text("등록된 자녀가 없습니다."))
                    : ListView.builder(
                        itemCount: children.length,
                        itemBuilder: (context, index) {
                          final child = children[index];
                          return ListTile(
                            leading: const Icon(Icons.child_care),
                            title: Text(child.name),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChildAddScreen()),
                    );
                  },
                  child: const Text("자녀 추가"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
