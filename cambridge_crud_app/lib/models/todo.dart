
import 'dart:ui';
import 'package:cambridge_crud/models/priority.dart';

class Todo {
  final Priority priority;
  final String title;
  final String description;

  Todo({
    required this.title,
    required this.priority,
    required this.description
  });

}