import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/todos.dart';

class EditTodoButton extends StatefulWidget {
  final todoIndex;

  const EditTodoButton({Key key, this.todoIndex}) : super(key: key);

  @override
  _EditTodoButtonState createState() => _EditTodoButtonState();
}

class _EditTodoButtonState extends State<EditTodoButton> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey?.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (context, todos, child) {
        final todoIndex = widget.todoIndex;
        final Todo todo = todos.items[todoIndex];

        return IconButton(
          color: Colors.blue,
          icon: Icon(Icons.edit),
          onPressed: () {
            return showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: Text('编辑 Todo'),
                  contentPadding: const EdgeInsets.all(24.0),
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autofocus: false,
                            autovalidate: false,
                            initialValue: todo.thing,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '输入你想做的事',
                            ),
                            onChanged: (val) {
                              todo.thing = val;
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return '想做的事不能为空';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          SwitchListTile(
                            title: const Text('是否完成'),
                            value: todo.finish,
                            onChanged: (bool value) {
                              todo.finish = value;
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              FlatButton(
                                child: Text('取消'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              RaisedButton(
                                child: Text(
                                  '确定',
                                  style: TextStyle(color: Colors.white),
                                ),
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  final isValid =
                                      _formKey.currentState.validate();

                                  if (!isValid) {
                                    return;
                                  }

                                  Navigator.pop(context);

                                  todos.editTodo(
                                    todoIndex,
                                    todo.thing,
                                    todo.finish,
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
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
