class Todo {
  String id;
  bool finish;
  String thing;

  Todo({
    this.id,
    this.thing,
    this.finish,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["_id"].toString(),
        thing: json["thing"],
        finish: json["finish"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thing": thing,
        "finish": finish,
      };
}
