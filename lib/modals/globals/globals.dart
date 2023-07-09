import 'package:flutter/material.dart';
import 'package:todo_app_flutter/modals/todo_convertor_modal.dart';

String Todo = '';
TextEditingController todoController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
List<TodoConvertor> all_Todos = [];
