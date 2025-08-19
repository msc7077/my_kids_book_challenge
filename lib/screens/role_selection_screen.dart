import 'package:flutter/material.dart';
import 'package:my_kids_book_challenge/screens/child_home_screen.dart';
import 'package:my_kids_book_challenge/screens/parent_home_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("역할 선택")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("👨‍👩‍👧 부모 모드"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ParentHomeScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("👧 자녀 모드"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ChildHomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
