import 'package:cambridge_crud/providers/todo_provider.dart';
import 'package:cambridge_crud/widgets/custom_alertdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cambridge_crud/models/todo.dart';

class TodoListTile extends ConsumerStatefulWidget {
  const TodoListTile({super.key, required this.todoItem});

  final Todo todoItem;

  @override
  ConsumerState<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends ConsumerState<TodoListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: widget.todoItem.priority.color,
      ),
      title: Text(widget.todoItem.title),
      subtitle: Text(widget.todoItem.description),
      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => CustomAlertDialog(
                      todoItem: widget.todoItem,
                      edit: true,
                    ));
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            ref.read(todoProvider.notifier).deleteTodo(widget.todoItem);
          },
        ),
      ]),
    );
  }
}
