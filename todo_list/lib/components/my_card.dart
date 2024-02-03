import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_task.dart';
import 'package:todo_list/utils/local_notifications.dart';

import '../utils/my_style.dart';

class MyCard extends StatefulWidget {
  final TodoTask task;
  const MyCard({super.key, required this.task});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  bool _isDone = false;

  void runScheduleNotification() {
    LocalNotifications().showScheduleNotification(
        id: widget.task.id,
        title: 'TODO task',
        body: 'Your ${widget.task.title} is due: ${widget.task.showDuration}',
        duration: widget.task.duration,
        payload: 'no clue');
  }

  void cancelScheduleNotification() {
    LocalNotifications().cancel(widget.task.id);
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      runScheduleNotification();
    });
  }

  // @override
  // void dispose() {
  //   setState(() {
  //     cancelScheduleNotification();
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: myGold,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      margin: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Show info
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title text
                Text(
                  widget.task.title,
                  style: const TextStyle(
                      color: myBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                // Date text
                const SizedBox(
                  height: gap,
                ),
                Text(
                  widget.task.showDate,
                  style: const TextStyle(
                    color: myBlack,
                    fontSize: 13.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                // Time text
                const SizedBox(
                  height: gap,
                ),
                Text(
                  widget.task.showTime,
                  style: const TextStyle(
                    color: myBlack,
                    fontSize: 13.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          // Done button
          IconButton(
            onPressed: () {
              setState(() {
                _isDone = !_isDone;
              });

              if (_isDone) {
                // cancel the schedule notification
                cancelScheduleNotification();
              } else {
                // reset the schedule notification
                runScheduleNotification();
              }
            },
            icon: _isDone
                ? const Icon(
                    Icons.circle_rounded,
                    color: myDarkGreen,
                  )
                : const Icon(
                    Icons.circle_outlined,
                    color: myBlack,
                  ),
            tooltip: _isDone ? 'Not done' : 'Done',
          ),
        ],
      ),
    );
  }
}
