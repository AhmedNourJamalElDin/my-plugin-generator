import 'package:flutter/material.dart';
import 'package:my_plugin/my_plugin.dart';

import 'main.my_plugin.g.dart';

void main() {
  runApp(const MyApp());
}

@SeeMe()
class YouShouldSeeMe {
}

@SeeMe()
class YouShouldSeeMeToo {
}

@SeeMeScanner()
Future<void> initSeeMeScanner() => $initSeeMeScanner;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    initSeeMeScanner();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}
