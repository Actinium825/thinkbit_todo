import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:thinkbit_todo/model/todo.dart';
import 'package:thinkbit_todo/todo/bloc/todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoState());

  void addTodo(String description) => emit(
    state.copyWith(
      todoList: [
        ...state.todoList,
        Todo(description),
      ],
    ),
  );

  void deleteTodo(int index) {
    final updatedList = state.todoList.toList()..removeAt(index);
    emit(state.copyWith(todoList: updatedList));
  }

  void toggleTodo(int index, bool isDone) {
    final updatedList = state.todoList
        .mapIndexed((todoIndex, todo) => index == todoIndex ? todo.copyWith(isDone: isDone) : todo)
        .toList();

    emit(state.copyWith(todoList: updatedList));
  }
}
