import 'package:flutter_test/flutter_test.dart';
import 'package:thinkbit_todo/todo/bloc/todo_cubic.dart';

void main() {
  group('TodoBloc', () {
    test('initial list is empty', () {
      expect(TodoCubit().state.todoList, equals([]));
    });
  });
}
