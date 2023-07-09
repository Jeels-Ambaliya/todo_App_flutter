import 'package:todo_app_flutter/modals/globals/globals.dart';
import 'package:todo_app_flutter/modals/todo_convertor_modal.dart';

class TodoHelper {
  TodoHelper._();

  static final TodoHelper todoHelper = TodoHelper._();

  addToTodoList({required Map data}) {
    TodoConvertor todoObject = TodoConvertor.fromMap(data: data);
    all_Todos.add(todoObject);
  }
}
