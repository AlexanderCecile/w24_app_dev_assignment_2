import 'package:flutter/material.dart';
import 'package:w24_app_dev_assignment_2/part_1.dart';
import 'package:w24_app_dev_assignment_2/part_2.dart';
import 'package:w24_app_dev_assignment_2/part_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'W24 App Dev Assignment 2', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('W24 App Dev Assignment 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Part1Main()),
                  );
                },
                child: Text('Part 1')),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Part2Main()),
                  );
                },
                child: Text('Part 2')),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Part3Main()),
                  );
                },
                child: Text('Part 3'))
          ],
        ),
      ),
    );
  }
}
