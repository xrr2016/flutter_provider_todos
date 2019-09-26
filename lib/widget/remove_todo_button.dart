import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/todos.dart';

class RemoveTodoButton extends StatelessWidget {
  final int todoIndex;

  const RemoveTodoButton({Key key, this.todoIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(builder: (_, todos, child) {
      final Todo todo = todos.items[todoIndex];

      return IconButton(
        color: Colors.red,
        icon: Icon(Icons.delete),
        onPressed: () {
          print('delete todo');
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('确认删除 ${todo.thing}?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      '取消',
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                    child: Text('确认'),
                    onPressed: () {
                      todos.removeTodo(todoIndex);
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    });
  }
}
