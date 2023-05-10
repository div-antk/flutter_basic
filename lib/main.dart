import 'package:flutter/material.dart';
import 'package:flutter_basic/next_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final myController = TextEditingController();
  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('タイトル'),
      ),
      body: Container(
          width: double.infinity,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'なまえ'),
                onChanged: (text) {
                  name = text;
                },
              ),
              TextField(
                controller: myController,
                decoration: InputDecoration(hintText: 'シュミ'),
              ),
              ElevatedButton(
                child: Text('新規登録'),
                onPressed: () {
                  final hobbyText = myController.text;
                },
              ),
            ],
          )),
    );
  }
}
