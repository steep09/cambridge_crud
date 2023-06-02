import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cambridge_crud/models/todo.dart';

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void deleteTodo(Todo todo) {
    state = [...state.where((item) => item != todo)];
  }

  void editTodo(Todo oldTodo, Todo newTodo) {
    final todoList = [...state.where((item) => item != oldTodo)];
    final index = state.indexOf(oldTodo);
    todoList.insert(index, newTodo);
    state = todoList;
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
  return TodoNotifier();
});

