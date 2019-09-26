import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'store/todos.dart';
import 'widget/add_todo_button.dart';
import 'widget/edit_todo_button.dart';
import 'widget/remove_todo_button.dart';

class TodosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Provider Todos')),
      body: Consumer<Todos>(
        builder: (ctx, todos, child) {
          List<Todo> items = todos.items;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (_, index) => Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    items[index].thing,
                    style: TextStyle(
                      color: items[index].finish ? Colors.green : Colors.grey,
                    ),
                  ),
                  trailing: Container(
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        EditTodoButton(todoIndex: index),
                        RemoveTodoButton(todoIndex: index),
                      ],
                    ),
                  ),
                ),
                Divider(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: AddTodoButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
