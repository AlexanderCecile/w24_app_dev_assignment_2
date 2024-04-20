import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:w24_app_dev_assignment_2/db_helper.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final dbHelper = DBHelper.instance;

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  late Future<List<Map<String, Object?>>?> nameObjs;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    nameObjs = dbHelper.getNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Part 1'),
        ),
        body: Column(
          children: [
            TextField(
              controller: _controller1,
              decoration: const InputDecoration(labelText: 'First name'),
            ),
            TextField(
              controller: _controller2,
              decoration: const InputDecoration(labelText: 'Last name'),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              OutlinedButton(
                  onPressed: () {
                    dbHelper.insertNames(_controller1.text, _controller2.text);
                    setState(() {
                      nameObjs = dbHelper.getNames();
                    });
                  },
                  child: const Text('Submit')),
              OutlinedButton(onPressed: () {}, child: const Text('Edit'))
            ]),
            Expanded(
              child: FutureBuilder(
                  future: nameObjs,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map<String, Object?>>?> snapshot) {
                    List<Widget> listElems = [];
                    if (snapshot.hasData && snapshot.data != null) {
                      for (final elem in snapshot.data!) {
                        listElems.add(
                          Row(
                            children: [
                              Expanded(child: Text(elem.toString())),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        );
                      }
                    }
                    return ListView(children: listElems);
                  }),
            ),
          ],
        ));
  }
}
