import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> getCloudflareTrace() async {
  final response =
      await http.get(Uri.parse('https://one.one.one.one/cdn-cgi/trace'));
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception();
  }
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  late Future<String> traceResult;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    traceResult = getCloudflareTrace();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Part 3'),
        ),
        body: Center(
            child: FutureBuilder(
                future: traceResult,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return const CircularProgressIndicator();
                  }
                })));
  }
}
