import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:thinkbit_todo/model/todo.dart';
import 'package:thinkbit_todo/todo/bloc/todo_cubic.dart';
import 'package:thinkbit_todo/todo/bloc/todo_state.dart';
import 'package:thinkbit_todo/todo/view/add_dialog.dart';
import 'package:thinkbit_todo/todo/view/todo_page.dart';

import '../../helpers/pump_app.dart';

class MockTodoCubit extends MockCubit<TodoState> implements TodoCubit {}

void main() {
  group('TodoPage', () {
    testWidgets('renders TodoView', (tester) async {
      await tester.pumpApp(const TodoPage());
      expect(find.byType(TodoView), findsOneWidget);
    });
  });

  group('TodoView', () {
    late TodoCubit todoCubit;

    setUp(() {
      todoCubit = MockTodoCubit();
    });

    testWidgets(
      'renders empty list',
      (tester) async {
        when(() => todoCubit.state).thenReturn(TodoState(todoList: []));
        await tester.pumpApp(
          BlocProvider.value(
            value: todoCubit,
            child: const TodoView(),
          ),
        );
        expect(find.byIcon(Icons.delete), findsNothing);
      },
    );

    testWidgets(
      'renders multiple todo list',
      (tester) async {
        final number = Random().nextInt(3) + 1;
        final todos = List.generate(number, (index) => Todo('$index'));
        when(() => todoCubit.state).thenReturn(TodoState(todoList: todos));
        await tester.pumpApp(
          BlocProvider.value(
            value: todoCubit,
            child: const TodoView(),
          ),
        );
        expect(find.byIcon(Icons.delete), findsExactly(number));
      },
    );

    testWidgets(
      'calls delete todo when delete button is tapped',
      (tester) async {
        when(() => todoCubit.state).thenReturn(TodoState(todoList: [const Todo('')]));
        // when(() => todoCubit.deleteTodo(0)).thenReturn(null);

        await tester.pumpApp(
          BlocProvider.value(
            value: todoCubit,
            child: const TodoView(),
          ),
        );
        await tester.tap(find.byIcon(Icons.delete));
        verify(() => todoCubit.deleteTodo(0)).called(1);
      },
    );

    testWidgets(
      'calls toggle todo when checkbox is tapped',
      (tester) async {
        when(() => todoCubit.state).thenReturn(TodoState(todoList: [const Todo('')]));
        // when(() => todoCubit.toggleTodo(0, true)).thenReturn(null);

        await tester.pumpApp(
          BlocProvider.value(
            value: todoCubit,
            child: const TodoView(),
          ),
        );
        await tester.tap(find.byType(Checkbox));
        verify(() => todoCubit.toggleTodo(0, true)).called(1);
      },
    );

    testWidgets(
      'calls add todo when add button is tapped',
      (tester) async {
        when(() => todoCubit.state).thenReturn(TodoState());
        // when(() => todoCubit.addTodo('a')).thenReturn(null);

        await tester.pumpApp(
          BlocProvider.value(
            value: todoCubit,
            child: const TodoView(),
          ),
        );

        final BuildContext context = tester.element(find.byType(TodoView));
        showDialog<void>(
          context: context,
          builder: (_) => AddDialog(contextTodoBloc: context),
        );

        await tester.pumpAndSettle(const Duration(seconds: 1));
        await tester.enterText(find.byType(TextField), 'a');
        await tester.tap(find.text('Add'));

        verify(() => todoCubit.addTodo('a')).called(1);
      },
    );
  });
}
