import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinkbit_todo/todo/bloc/todo_cubic.dart';
import 'package:thinkbit_todo/todo/bloc/todo_state.dart';
import 'package:thinkbit_todo/todo/view/add_dialog.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoCubit(),
      child: const TodoView(),
    );
  }
}

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (_, state) {
          final todoList = state.todoList;

          return ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (_, index) {
              final todo = todoList[index];
              return ListTile(
                title: Text(todo.description),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => context.read<TodoCubit>().toggleTodo(index, !todo.isDone),
                ),
                trailing: IconButton(
                  onPressed: () => context.read<TodoCubit>().deleteTodo(index),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<void>(
          context: context,
          builder: (_) => AddDialog(contextTodoBloc: context),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
