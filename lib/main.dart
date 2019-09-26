import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todos_page.dart';
import 'store/todos.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ChangeNotifierProvider(
        builder: (context) => Todos(),
        child: TodosPage(),
      ),
    );
  }
}
