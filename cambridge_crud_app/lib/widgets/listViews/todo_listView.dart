import 'package:cambridge_crud/providers/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:cambridge_crud/models/todo.dart';
import 'package:cambridge_crud/widgets/listViews/todo_listtile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListView extends ConsumerStatefulWidget {
  const TodoListView({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends ConsumerState<TodoListView> {
  @override
  Widget build(BuildContext context) {
    List<Todo> todoList = ref.watch(todoProvider);

    return ListView.builder(
      itemCount: todoList.length,
      itemBuilder: (ctx, index) {
        return TodoListTile(todoItem: todoList[index]);
      },
    );
  }
}
