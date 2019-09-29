import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../request.dart';
import '../model/todo.dart';

class Todos extends ChangeNotifier {
  List<Todo> _items = [];

  Dio _dio = craeteDio();

  get items {
    return [..._items];
  }

  void refresh() {
    notifyListeners();
  }

  Future<List> getTodos() async {
    try {
      Response response = await _dio.get('/todos');

      final list = response.data as List;
      _items = List<Todo>.from(list.map((i) => Todo.fromJson(i)).toList());

      return items;
    } on DioError catch (err) {
      throw err;
    }
  }

  Future addTodo(String thing) async {
    try {
      Response response = await _dio.post('/todos', data: {
        "thing": thing,
        "finish": false,
      });

      Todo todo = Todo(
        thing: thing,
        id: response.data["_id"],
        finish: response.data["finish"],
      );

      _items.insert(0, todo);
      refresh();
    } on DioError catch (err) {
      throw err;
    }
  }

  Future removeTodo(int index) async {
    try {
      String todoId = _items[index].id;
      await _dio.delete("/todos/$todoId");
      _items.removeAt(index);
      refresh();
    } catch (err) {
      throw err;
    }
  }

  Future editTodo(int index, String thing, bool finish) async {
    String todoId = _items[index].id;

    try {
      await _dio.put("/todos/$todoId", data: {
        "thing": thing,
        "finish": finish,
      });

      Todo todo = _items[index];
      todo.thing = thing;
      todo.finish = finish;
      refresh();
    } catch (e) {
      throw e;
    }
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
