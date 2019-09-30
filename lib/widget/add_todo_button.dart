import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/todos.dart';

class AddTodoButton extends StatefulWidget {
  @override
  _AddTodoButtonState createState() => _AddTodoButtonState();
}

class _AddTodoButtonState extends State<AddTodoButton> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Todos>(
      builder: (_, todos, child) {
        _addTodo() async {
          final isValid = _formKey.currentState.validate();

          if (!isValid) {
            return;
          }

          final thing = _controller.value.text;

          try {
            await todos.addTodo(thing);
            Navigator.pop(context);
            _controller.clear();
          } catch (e) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('新增代办失败了，请重试。')),
            );
          }
        }

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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            autofocus: true,
                            autovalidate: false,
                            controller: _controller,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '输入你想做的事',
                            ),
                            validator: (val) {
                              if (val.isEmpty) {
                                return '想做的事不能为空';
                              }

                              bool isExist = todos.isTodoExist(val);

                              if (isExist) {
                                return '这件事情已经存在了';
                              }
                              return null;
                            },
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
                                onPressed: _addTodo,
                              ),
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
