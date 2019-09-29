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
      body: FutureBuilder(
        future: Provider.of<Todos>(context).getTodos(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.done:
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(
                    '出错了，请重试',
                    style: TextStyle(fontSize: 18.0, color: Colors.red),
                  ),
                );
              }

              List items = snapshot.data;

              if (items == null) {
                return Center(
                  child: Text(
                    '还没有代办事项，快去添加吧',
                    style: TextStyle(fontSize: 18.0),
                  ),
                );
              }

              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            items[index].thing,
                            style: TextStyle(
                              color: items[index].finish
                                  ? Colors.green
                                  : Colors.grey,
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
                    );
                  });
          }
          return null;
        },
      ),
      floatingActionButton: Consumer<Todos>(
        builder: (_, todos, child) {
          return AddTodoButton();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
