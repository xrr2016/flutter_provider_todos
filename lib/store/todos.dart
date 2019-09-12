import 'package:flutter/foundation.dart';

class Todo {
  bool finish;
  final String thing;

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

  void addTodo(Todo todo) {
    _items.insert(0, todo);
    notifyListeners();
  }

  void removeTodo(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void toggleFinish(int index) {
    final todo = _items[index];
    todo.finish = !todo.finish;
    notifyListeners();
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
