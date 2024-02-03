import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_task.dart';

import '../components/my_textfield.dart';
import '../components/date_time_picker.dart';
import '../components/my_hint.dart';
import '../utils/my_style.dart';

class CreateNewScreen extends StatefulWidget {
  const CreateNewScreen({super.key});

  @override
  State<CreateNewScreen> createState() => _CreateNewScreenState();
}

class _CreateNewScreenState extends State<CreateNewScreen> {
  // text controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // init current datetime
  DateTime dateTime = DateTime.now();

  // init title
  final String title = 'New task';

  // Create a new task
  void createNewTask() {
    TodoTask newTask = TodoTask(
        titleController.text.isEmpty ? title : titleController.text, dateTime);

    // switch to the home screen
    Navigator.pop(context, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: myGold,
          ),
          backgroundColor: myBlack,
          actions: [
            IconButton(
              onPressed: createNewTask,
              icon: const Icon(Icons.done),
              color: myGold,
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
        child: Column(
          children: [
            // Title textfield
            const MyHint(title: 'Title:'),
            MyTextField(
              controller: titleController,
              fontSize: 30,
              isBold: true,
              isFocus: true,
              hintText: title,
            ),
            const SizedBox(
              height: gap,
            ),
            // Date time picker
            const MyHint(title: 'Duration:'),
            DateTimePicker(
              initialDate: dateTime,
              onDateTimeChanged: (DateTime duration) {
                dateTime = duration;
              },
            ),
            // Description textfield
            // const SizedBox(
            //   height: gap,
            // ),
            // const MyHint(title: 'Description:'),
            // MyTextField(
            //   controller: descriptionController,
            //   isBox: true,
            //   maxLines: 5,
            // )
          ],
        ),
      ),
    );
  }
}
