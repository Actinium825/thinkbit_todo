import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thinkbit_todo/l10n/l10n.dart';
import 'package:thinkbit_todo/todo/bloc/todo_cubic.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({required this.contextTodoBloc, super.key});

  final BuildContext contextTodoBloc;

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late final TextEditingController _descriptionTextController;

  @override
  void initState() {
    _descriptionTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionTextController.dispose();
    super.dispose();
  }

  void _onAddTodo() {
    if (_descriptionTextController.text.isEmpty) return Navigator.of(context).pop();

    widget.contextTodoBloc.read<TodoCubit>().addTodo(_descriptionTextController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _descriptionTextController, autofocus: true),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text(l10n.cancelButtonLabel),
                ),
                TextButton(
                  onPressed: _onAddTodo,
                  child: Text(l10n.addButtonLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
