import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'store/todos.dart';
import 'widget/add_todo_button.dart';

class HomePage extends StatelessWidget {
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
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Checkbox(
                          value: items[index].finish,
                          onChanged: (_) {
                            final todo = items[index];
                            todos.toggleFinish(index);
                            print(todo.finish);
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            print('delete todo');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('确认删除 ${items[index].thing}?'),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        '确认',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onPressed: () {
                                        todos.removeTodo(index);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('取消'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                        )
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
