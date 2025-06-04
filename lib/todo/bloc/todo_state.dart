import 'package:thinkbit_todo/model/todo.dart';

class TodoState {
  final List<Todo> todoList;

  TodoState({this.todoList = const []});

  TodoState copyWith({List<Todo>? todoList}) => TodoState(todoList: todoList ?? this.todoList);
}
