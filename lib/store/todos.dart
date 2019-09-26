import 'package:flutter/foundation.dart';

class Todo {
  bool finish;
  String thing;

  Todo({
    @required this.thing,
    this.finish = false,
  });
}

class Todos extends ChangeNotifier {
  List<Todo> _items = [
    Todo(thing: 'Play lol', finish: true),
    Todo(thing: 'Learn flutter', finish: false),
    Todo(thing: 'Read book', finish: false),
    Todo(thing: 'Watch anime', finish: false),
  ];

  get items {
    return [..._items];
  }

  get finishTodos {
    return _items.where((todo) => todo.finish);
  }

  void refresh() {
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _items.insert(0, todo);

    refresh();
  }

  void removeTodo(int index) {
    _items.removeAt(index);

    refresh();
  }

  void editTodo(int index, String newThing, bool isFinish) {
    Todo todo = _items[index];
    todo.thing = newThing;
    todo.finish = isFinish;

    refresh();
  }

  void toggleFinish(int index) {
    final todo = _items[index];
    todo.finish = !todo.finish;

    refresh();
  }

  bool isTodoExist(String thing) {
    bool isExist = false;

    for (var i = 0; i < _items.length; i++) {
      final todo = _items[i];
      if (todo.thing == thing) {
        isExist = true;
      }
    }

    return isExist;
  }
}
