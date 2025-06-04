class Todo {
  final String description;
  final bool isDone;

  const Todo(this.description, [this.isDone = false]);

  Todo copyWith({
    String? description,
    bool? isDone,
  }) {
    return Todo(
      description ?? this.description,
      isDone ?? this.isDone,
    );
  }
}
