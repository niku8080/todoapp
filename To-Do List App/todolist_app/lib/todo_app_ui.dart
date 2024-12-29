import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:todolist_app/todo_model.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoAppUi(),
    );
  }
}

class TodoAppUi extends StatefulWidget {
  const TodoAppUi({super.key});
  @override
  State<TodoAppUi> createState() => _TodoState();
}

class _TodoState extends State<TodoAppUi> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  Color? boxColor(int i) {
    i = (i % 4);
    switch (i) {
      case 0:
        return const Color.fromRGBO(250, 232, 232, 1);
        
      case 1:
        return const Color.fromRGBO(232, 237, 250, 1);

      case 2:
        return const Color.fromRGBO(250, 249, 232, 1);

      case 3:
        return const Color.fromRGBO(250, 232, 250, 1);
    }
    return null;
  }

  List<ToDoModelClass> todoCards = [
    // TodoModelclass(
    //   title: "Java",
    //   description: "OOPS, Exception",
    //   date: "17 Oct 2024",
    // ),
    // TodoModelclass(
    //   title: "Java",
    //   description: "OOPS, Exception",
    //   date: "17 Oct 2024",
    // ),
  ];

  // List<dynamic> todoCards = [];

  void submit(bool doEdit, [ToDoModelClass? obj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (doEdit) {
        obj!.title = titleController.text;
        obj.description = descriptionController.text;
        obj.date = dateController.text;
      } else {
        todoCards.add(ToDoModelClass(
          title: titleController.text,
          description: descriptionController.text,
          date: dateController.text,
        ));
      }
      Navigator.of(context).pop();
      clearField();
      setState(() {});
    }
    clearField();
    setState(() {});
  }

  void clearField() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void openAddnote(bool doEdit, [ToDoModelClass? obj]) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 8.0,
            left: 8,
            right: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create To-Do",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Text(
                "Title",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(2, 167, 177, 1),
                ),
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  //label: Text('Title'),
                ),
              ),
              const Text(
                "Description",
                style:TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(2, 167, 177, 1),
                ),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const Text(
                "Date",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(2, 167, 177, 1),
                ),
              ),
              TextField(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(2024),
                    lastDate: DateTime(2026),
                  );
                  String formattedDate = DateFormat.yMMMd().format(pickedDate!);

                  setState(() {
                    dateController.text = formattedDate;
                  });
                },
                controller: dateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_month),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (doEdit) {
                      submit(true, obj);
                    } else {
                      submit(false);
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  style: const ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Color.fromRGBO(2, 167, 177, 1)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "To-do List",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          toolbarHeight: 70,
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        ),
        body: ListView.builder(
          itemCount: todoCards.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: boxColor(index),
              ),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          clipBehavior: Clip.antiAlias,
                          height: 50,
                          padding: const EdgeInsets.all(8.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset("assets/image.png"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todoCards[index].title,
                              //titleController.text,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 243,
                              height: 44,
                              child: Text(
                                todoCards[index].description,
                                style: const TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        todoCards[index].date,
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          titleController.text = todoCards[index].title;
                          descriptionController.text =
                              todoCards[index].description;
                          dateController.text = todoCards[index].date;

                          openAddnote(true, todoCards[index]);

                          setState(() {});
                        },
                        child: const Icon(
                          Icons.edit_outlined,
                          color: const Color.fromRGBO(2, 167, 177, 1),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          todoCards.remove(todoCards[index]);
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.delete_outline,
                          color: const Color.fromRGBO(2, 167, 177, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            clearField();
            openAddnote(false);
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        ),
      ),
    );
  }
}