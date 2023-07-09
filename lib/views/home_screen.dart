import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/controllers/providers/time_provider.dart';
import 'package:todo_app_flutter/modals/todo_convertor_modal.dart';

import '../controllers/helpers/db_helper.dart';
import '../controllers/helpers/todo_helper.dart';
import '../controllers/providers/theme_provider.dart';
import '../modals/globals/globals.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  late Future data;

  List<TodoConvertor> allTodos = [];
  final pdf = pw.Document();

  makePdf() {
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Container(
              alignment: pw.Alignment.topCenter,
              height: double.infinity,
              width: double.infinity,
              color: PdfColors.white,
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Row(children: [
                    pw.Container(
                        alignment: pw.Alignment.center,
                        width: 380,
                        height: 40,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            width: 2,
                            color: PdfColors.black,
                          ),
                        ),
                        child: pw.Padding(
                          padding: const pw.EdgeInsets.all(10),
                          child: pw.Text(
                            'Your TODOs',
                            style: pw.TextStyle(
                                fontSize: 25, fontWeight: pw.FontWeight.bold),
                          ),
                        )),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      width: 100,
                      height: 40,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(width: 2, color: PdfColors.black),
                      ),
                      child: pw.Text(
                        'Time',
                        style: pw.TextStyle(
                            fontSize: 25, fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ]),
                  pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: all_Todos
                        .map(
                          (e) => pw.Row(
                            children: [
                              pw.Container(
                                  alignment: pw.Alignment.center,
                                  width: 380,
                                  height: 30,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 2, color: PdfColors.black),
                                  ),
                                  child: pw.Padding(
                                    padding: const pw.EdgeInsets.all(10),
                                    child: pw.Text(
                                      e.Todo,
                                      style: const pw.TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  )),
                              pw.Container(
                                alignment: pw.Alignment.center,
                                width: 100,
                                height: 30,
                                decoration: pw.BoxDecoration(
                                  border: pw.Border.all(
                                      width: 2, color: PdfColors.black),
                                ),
                                child: pw.Text(
                                  e.Time,
                                  style: const pw.TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  setTodos() {
    setState(() {
      allTodos = all_Todos;
    });
  }

  @override
  void initState() {
    super.initState();
    setTodos();
    DataBaseHelper.dataBaseHelper.initDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Todo App',
          style: GoogleFonts.alata(
            fontWeight: FontWeight.w900,
            fontSize: 40,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              },
              icon: Icon(
                (Provider.of<ThemeProvider>(context, listen: false)
                            .themeModal
                            .isDark ==
                        false)
                    ? Icons.sunny
                    : Icons.wb_sunny_outlined,
                size: 30,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              setState(() {
                makePdf();
              });
              pdf.editPage(0, pw.Page(
                build: (context) {
                  return pw.Container(
                    alignment: pw.Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    color: PdfColors.white,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Row(children: [
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 400,
                              height: 40,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 2, color: PdfColors.black),
                              ),
                              child: pw.Text(
                                'Your TODOs',
                                style: pw.TextStyle(
                                    fontSize: 25,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                              width: 100,
                              height: 40,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 2, color: PdfColors.black),
                              ),
                              child: pw.Text(
                                'Time',
                                style: pw.TextStyle(
                                    fontSize: 25,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ]),
                          pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: all_Todos
                                .map(
                                  (e) => pw.Row(
                                    children: [
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 400,
                                        height: 30,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 2, color: PdfColors.black),
                                        ),
                                        child: pw.Text(
                                          e.Todo,
                                          style: const pw.TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 100,
                                        height: 30,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 2, color: PdfColors.black),
                                        ),
                                        child: pw.Text(
                                          e.Time,
                                          style: const pw.TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ]),
                  );
                },
              ));
              Uint8List data = await pdf.save();
              await Printing.layoutPdf(onLayout: (format) => data);
            },
            icon: const Icon(
              Icons.picture_as_pdf,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All ToDos',
                      style: GoogleFonts.vampiroOne(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: (allTodos.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add_rounded,
                          size: 230,
                          color: Colors.grey.shade300,
                        ),
                        Text(
                          'No Todo Exist...',
                          style: GoogleFonts.alata(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  )
                : StatefulBuilder(
                    builder: (context, setState) {
                      return FutureBuilder(
                        future: DataBaseHelper.dataBaseHelper.fetchAllRecodes(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<TodoConvertor>? myTodo = snapshot.data;
                            return ListView.builder(
                              itemCount: myTodo?.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 4),
                                  child: Card(
                                    elevation: 4,
                                    child: ListTile(
                                      leading: Text(
                                        '${index + 1})',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      title: Text(
                                        myTodo![index].Todo.toString(),
                                        style: GoogleFonts.alata(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                        ),
                                      ),
                                      trailing: Text(
                                        myTodo[index].Time.toString(),
                                        style: GoogleFonts.alata(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return Center(
                            child: Text('${snapshot.error}'),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: StatefulBuilder(
        builder: (context, setState) {
          return FloatingActionButton(
            onPressed: () {
              if (all_Todos.isEmpty) {
                showModalBottomSheet(
                  elevation: 3,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          height: 320,
                          decoration: BoxDecoration(
                            color: (Provider.of<ThemeProvider>(context)
                                        .themeModal
                                        .isDark ==
                                    false)
                                ? Colors.white
                                : Colors.grey.shade700,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Add Your Todo',
                                    style: GoogleFonts.alata(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                    onSaved: (val) {
                                      setState(() {
                                        Todo = val!;
                                      });
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please enter your task';
                                      }
                                      return null;
                                    },
                                    controller: todoController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter your Todo',
                                      filled: true,
                                      prefix: const SizedBox(
                                        width: 10,
                                      ),
                                      hintText: 'Enter TODOs...',
                                      suffixIcon: Icon(
                                        Icons.edit,
                                        color:
                                            (Provider.of<ThemeProvider>(context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade600
                                                : Colors.grey.shade200,
                                        size: 26,
                                      ),
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color:
                                            (Provider.of<ThemeProvider>(context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade600
                                                : Colors.grey.shade200,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                      fillColor:
                                          (Provider.of<ThemeProvider>(context)
                                                      .themeModal
                                                      .isDark ==
                                                  false)
                                              ? Colors.grey.shade200
                                              : Colors.grey.shade600,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${Provider.of<TimeProvider>(context).todoModal.Time}:00 ${Provider.of<TimeProvider>(context).todoModal.Note}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: pi,
                                      child: Container(
                                        width: 0,
                                        height: 33,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 2,
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade400
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    OutlinedButton(
                                      style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                          BorderSide(
                                            color: (Provider.of<ThemeProvider>(
                                                            context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade800
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (Provider.of<TimeProvider>(context,
                                                        listen: false)
                                                    .todoModal
                                                    .Time ==
                                                8 &&
                                            Provider.of<TimeProvider>(context,
                                                        listen: false)
                                                    .todoModal
                                                    .Note ==
                                                'PM') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              dismissDirection:
                                                  DismissDirection.down,
                                              duration: Duration(
                                                milliseconds: 600,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                vertical: 230,
                                                horizontal: 10,
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Time reached it's limit.."),
                                            ),
                                          );
                                        }
                                        Provider.of<TimeProvider>(context,
                                                listen: false)
                                            .increment();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Text(
                                          'Skip Time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: (Provider.of<ThemeProvider>(
                                                            context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade700
                                                : Colors.grey.shade200,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Spacer(),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            BorderSide(
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade800
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          todoController.clear();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade700
                                                      : Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      StatefulBuilder(
                                        builder: (context, setState) {
                                          setState(() {});
                                          return ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                (Provider.of<ThemeProvider>(
                                                                context)
                                                            .themeModal
                                                            .isDark ==
                                                        false)
                                                    ? Colors.grey.shade300
                                                    : Colors.grey,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState!.save();
                                                  Map temporary = {
                                                    'Time':
                                                        '${Provider.of<TimeProvider>(context, listen: false).todoModal.Time}:00 ${Provider.of<TimeProvider>(context, listen: false).todoModal.Note}',
                                                    'Todo': Todo,
                                                  };
                                                  setState(() {
                                                    TodoHelper.todoHelper
                                                        .addToTodoList(
                                                            data: temporary);
                                                  });
                                                  Provider.of<TimeProvider>(
                                                          context,
                                                          listen: false)
                                                      .increment();
                                                  todoController.clear();
                                                  setState(() {
                                                    allTodos = all_Todos;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                'Save',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color:
                                                      (Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .themeModal
                                                                  .isDark ==
                                                              false)
                                                          ? Colors.grey.shade700
                                                          : Colors
                                                              .grey.shade200,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                if (all_Todos.last.Time == '7:00 PM') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      dismissDirection: DismissDirection.down,
                      duration: Duration(
                        milliseconds: 600,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content: Text("Time reached it's limit.."),
                    ),
                  );
                } else {
                  showModalBottomSheet(
                    elevation: 3,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            height: 320,
                            decoration: BoxDecoration(
                              color: (Provider.of<ThemeProvider>(context)
                                          .themeModal
                                          .isDark ==
                                      false)
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Add Your Todo',
                                      style: GoogleFonts.alata(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextFormField(
                                      onSaved: (val) {
                                        Todo = val!;
                                      },
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Please enter your task';
                                        }
                                        return null;
                                      },
                                      controller: todoController,
                                      onChanged: (val) {},
                                      decoration: InputDecoration(
                                        labelText: 'Enter your Todo',
                                        filled: true,
                                        prefix: const SizedBox(
                                          width: 10,
                                        ),
                                        hintText: 'Enter TODOs...',
                                        suffixIcon: Icon(
                                          Icons.edit,
                                          color: (Provider.of<ThemeProvider>(
                                                          context)
                                                      .themeModal
                                                      .isDark ==
                                                  false)
                                              ? Colors.grey.shade600
                                              : Colors.grey.shade200,
                                          size: 26,
                                        ),
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: (Provider.of<ThemeProvider>(
                                                          context)
                                                      .themeModal
                                                      .isDark ==
                                                  false)
                                              ? Colors.grey.shade600
                                              : Colors.grey.shade200,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                        ),
                                        fillColor:
                                            (Provider.of<ThemeProvider>(context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade200
                                                : Colors.grey.shade600,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${Provider.of<TimeProvider>(context).todoModal.Time}:00 ${Provider.of<TimeProvider>(context).todoModal.Note}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Transform.rotate(
                                        angle: pi,
                                        child: Container(
                                          width: 0,
                                          height: 33,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                width: 2,
                                                color:
                                                    (Provider.of<ThemeProvider>(
                                                                    context)
                                                                .themeModal
                                                                .isDark ==
                                                            false)
                                                        ? Colors.grey.shade400
                                                        : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            BorderSide(
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade800
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (Provider.of<TimeProvider>(context,
                                                          listen: false)
                                                      .todoModal
                                                      .Time ==
                                                  8 &&
                                              Provider.of<TimeProvider>(context,
                                                          listen: false)
                                                      .todoModal
                                                      .Note ==
                                                  'PM') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                dismissDirection:
                                                    DismissDirection.down,
                                                duration: Duration(
                                                  milliseconds: 600,
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 230,
                                                  horizontal: 10,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "Time reached it's limit.."),
                                              ),
                                            );
                                          }
                                          Provider.of<TimeProvider>(context,
                                                  listen: false)
                                              .increment();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Text(
                                            'Skip Time',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade700
                                                      : Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Spacer(),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        OutlinedButton(
                                          style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                              BorderSide(
                                                color:
                                                    (Provider.of<ThemeProvider>(
                                                                    context)
                                                                .themeModal
                                                                .isDark ==
                                                            false)
                                                        ? Colors.grey.shade800
                                                        : Colors.white,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            todoController.clear();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color:
                                                    (Provider.of<ThemeProvider>(
                                                                    context)
                                                                .themeModal
                                                                .isDark ==
                                                            false)
                                                        ? Colors.grey.shade700
                                                        : Colors.grey.shade200,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        StatefulBuilder(
                                          builder: (context, setState) {
                                            return ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade300
                                                      : Colors.grey,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState!.save();
                                                  Map temporary = {
                                                    'Time':
                                                        '${Provider.of<TimeProvider>(context, listen: false).todoModal.Time}:00 ${Provider.of<TimeProvider>(context, listen: false).todoModal.Note}',
                                                    'Todo': Todo,
                                                  };
                                                  TodoHelper.todoHelper
                                                      .addToTodoList(
                                                          data: temporary);
                                                  Provider.of<TimeProvider>(
                                                          context,
                                                          listen: true)
                                                      .increment();
                                                  setState(() {
                                                    setTodos();
                                                    all_Todos;
                                                  });
                                                  DataBaseHelper.dataBaseHelper
                                                      .insertRecord(
                                                          todo:
                                                              temporary['Todo'],
                                                          time: temporary[
                                                              'Time']);
                                                  setTodos();
                                                  todoController.clear();
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color:
                                                        (Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .themeModal
                                                                    .isDark ==
                                                                false)
                                                            ? Colors
                                                                .grey.shade700
                                                            : Colors
                                                                .grey.shade200,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              }
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
