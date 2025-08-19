import 'package:flutter/material.dart';

class ChildHomeScreen extends StatelessWidget {
  const ChildHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("자녀 홈")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "👧 자녀 모드",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: 챕터 리스트 화면 연결 예정
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("챕터 리스트로 이동 예정")));
              },
              child: const Text("책 읽기 시작하기"),
            ),
          ],
        ),
      ),
    );
  }
}
