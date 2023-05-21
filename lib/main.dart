import 'package:flutter/material.dart';

void main() => runApp(MyTodoApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

// StatefulWidgetを継承するとStateを扱うことができる
// このWidgetを表示すると、Stateを元にUIが作成される
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

// Stateを継承して使う
class _MyWidgetState extends State<MyWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(count.toString()),
        TextButton(
          onPressed: () {
            // データを更新するときは setState を学ぶ
            setState(() {
              count += 1;
            });
          },
          child: Text('カウントアップ'),
        ),
      ],
    );
  }
}

class MyTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo App',
      theme: ThemeData(
        // テーマカラー
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
    // Todoリストのデータ
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),
      // データを元にリストを作成
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todoList[index]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newListText = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              // 遷移先の画面としてリスト追加画面を指定
              return TodoAddPage();
            }),
          );
          if (newListText != null) {
            // キャンセルした場合は newListTextが null になる
            setState(() {
              todoList.add(newListText);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// リスト追加画面用
class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  
  // 入力されたテキストをデータをして持つ
  String _text = '';

  // データを元に表示するWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト追加'),
      ),
      body: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 入力されたテキストを表示
            Text(_text, style: TextStyle(color: Colors.blue)),
            const SizedBox(height: 8),
            TextField(
              // 入力されたテキストの値を受け取る
              onChanged: (String value) {
                // データが変更されたことを知らせる（画面を更新する）
                setState(() {
                  // データを変更
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // popの引数から前の画面にデータを渡す
                  Navigator.of(context).pop(_text);
                },
              child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              // キャンセルボタン
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(_text);
                },
              child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}