import 'package:flutter/material.dart';
import 'package:w24_app_dev_assignment_2/part_1.dart' as part_1;
import 'package:w24_app_dev_assignment_2/part_2.dart' as part_2;
import 'package:w24_app_dev_assignment_2/part_3.dart' as part_3;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'W24 App Dev Assignment 2', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('W24 App Dev Assignment 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const part_1.Main()),
                  );
                },
                child: const Text('Part 1')),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const part_2.ProfilePage()),
                  );
                },
                child: const Text('Part 2')),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const part_3.Main()),
                  );
                },
                child: const Text('Part 3'))
          ],
        ),
      ),
    );
  }
}
