import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DrawerMain extends StatefulWidget {
  const DrawerMain({super.key});

  @override
  State<DrawerMain> createState() => _DrawerMainState();
}

class _DrawerMainState extends State<DrawerMain> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      const DrawerHeader(child: Text('Header')),
      ListTile(
        title: const Text('Profile'),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage()));
        },
      ),
      ListTile(
        title: const Text('Notifications'),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CalendarPage()));
        },
      ),
      ListTile(
        title: const Text('Setings'),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsPage()));
        },
      ),
      ListTile(
        title: const Text('Log out'),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const LogoutPage()));
        },
      )
    ]));
  }
}

Future<dynamic> getData() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception();
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<dynamic> picData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    picData = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile page')),
      drawer: const DrawerMain(),
      body: FutureBuilder(
          future: picData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> listTiles = [];

            if (snapshot.hasData && snapshot.data is List) {
              List dataAsList = snapshot.data as List;
              for (final elem in dataAsList) {
                listTiles.add(Row(children: [
                  Expanded(
                      child: Image.network(elem!['thumbnailUrl'].toString())),
                  Expanded(child: Text(elem.toString())),
                  Expanded(child: Image.network(elem!['url'].toString()))
                ]));
              }
            }
            return ListView(children: listTiles);
          }),
    );
  }
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime currentDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Calendar')),
        drawer: const DrawerMain(),
        body: Center(
          child: OutlinedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: const Text('Open calendar')),
        ));
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: const DrawerMain(),
      body: const Center(
          child: Text(
              'Various settings here. I know how to add basic buttons etc. to a screen, so I will refrain from spending time designing an amazing UI here.')),
    );
  }
}

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Log out')),
        drawer: const DrawerMain(),
        body: Center(
            child: OutlinedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logging out!')));
                },
                child: const Text('Log out'))));
  }
}
