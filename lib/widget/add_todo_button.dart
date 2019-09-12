import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/todos.dart';

class AddTodoButton extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (_, todos, child) {
        return FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('add todo');
            return showDialog(
              context: context,
              builder: (BuildContext _) {
                return SimpleDialog(
                  title: Text('添加 Todo'),
                  contentPadding: const EdgeInsets.all(24.0),
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '输入你想做的事',
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: Text('取消'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        RaisedButton(
                          child: Text(
                            '确定',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            final thing = _controller.value.text;

                            bool isExist = todos.isTodoExist(thing);

                            if (isExist) {
                              Navigator.pop(context);

                              Scaffold.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('这件事情已经存在了'),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              todos.addTodo(Todo(
                                thing: thing,
                                finish: false,
                              ));
                              Navigator.pop(context);
                              _controller.clear();
                            }
                          },
                        )
                      ],
                    )
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
