import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_task.dart';
import 'package:todo_list/screens/create_new_screen.dart';

import '../enums/stats_duration.dart';
import '../utils/my_style.dart';
import '../components/my_hint.dart';
import '../components/slide_left_route.dart';
import '../components/my_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TodoTask> allTodoTasks = [];
  List<TodoTask> todoTasks = [];
  StatsDuration duration = StatsDuration.all;
  final TextEditingController searchController = TextEditingController();

  // support for the search function
  @override
  void initState() {
    super.initState();
    searchController.addListener(queryListener);

    // init the search list
    setState(() {
      todoTasks = allTodoTasks;
    });
  }

  // support for the search function
  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    super.dispose();
  }

  // support for the search function
  void queryListener() {
    search(searchController.text);
  }

  // search function
  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        todoTasks = allTodoTasks;
      });

      return;
    }

    setState(() {
      todoTasks = allTodoTasks
          .where(
              (task) => task.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Switch to the create-new-screen
  Future<void> _navigateAndDisplayCreateNew(BuildContext context) async {
    final TodoTask task = await Navigator.push(
        context, SlideLeftRoute(page: const CreateNewScreen()));

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    //add a new task to all todo task
    setState(() {
      allTodoTasks.insert(0, task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TODO',
          style: TextStyle(
            color: myGold,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: myBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // "Create new" button
            FilledButton(
              onPressed: () {
                _navigateAndDisplayCreateNew(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: myGold,
              ),
              child: const Padding(
                padding: EdgeInsets.all(13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: myBlack,
                    ),
                    Text(
                      'Create new',
                      style: TextStyle(fontSize: 20, color: myBlack),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: gap,
            ),
            // Select a duration
            Align(
              alignment: Alignment.topLeft,
              child: DropdownMenu<StatsDuration>(
                initialSelection: duration,
                onSelected: (StatsDuration? newValue) {
                  // This is called when the user selects an item.
                  setState(() {
                    duration = newValue!;
                  });

                  // create a format-today to check with duration stats
                  DateTime today = DateTime.now();
                  String formatToday =
                      '${today.year}/${today.month.toString().padLeft(2, '0')}/${today.day.toString().padLeft(2, '0')}';

                  // show the todo list which belongs to the stats of duration
                  switch (duration) {
                    case StatsDuration.all:
                      {
                        // is not searching
                        if (todoTasks.isEmpty) {
                          setState(() {
                            todoTasks = allTodoTasks;
                          });
                        } else {
                          // is searching
                          setState(() {
                            todoTasks = allTodoTasks
                                .where((task) => task.title
                                    .toLowerCase()
                                    .contains(
                                        searchController.text.toLowerCase()))
                                .toList();
                          });
                        }

                        break;
                      }

                    case StatsDuration.today:
                      {
                        // is not searching
                        if (todoTasks.isEmpty) {
                          setState(() {
                            todoTasks = allTodoTasks
                                .where((task) => task.showDate == formatToday)
                                .toList();
                          });
                        } else {
                          // is searching
                          setState(() {
                            todoTasks = allTodoTasks
                                .where((task) => task.title
                                    .toLowerCase()
                                    .contains(
                                        searchController.text.toLowerCase()))
                                .toList()
                                .where((task) => task.showDate == formatToday)
                                .toList();
                          });
                        }

                        break;
                      }

                    case StatsDuration.upcoming:
                      {
                        // is not searching
                        if (todoTasks.isEmpty) {
                          setState(() {
                            todoTasks = allTodoTasks
                                .where((task) => task.showDate != formatToday)
                                .toList();
                          });
                        } else {
                          // is searching
                          setState(() {
                            todoTasks = allTodoTasks
                                .where((task) => task.title
                                    .toLowerCase()
                                    .contains(
                                        searchController.text.toLowerCase()))
                                .toList()
                                .where((task) => task.showDate != formatToday)
                                .toList();
                          });
                        }

                        break;
                      }
                  }
                },
                dropdownMenuEntries:
                    StatsDuration.values.map((StatsDuration value) {
                  // show the dropdown menu of duration stats
                  return DropdownMenuEntry<StatsDuration>(
                    value: value,
                    label: value.name.toUpperCase(),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: gap,
            ),
            // Search bar
            SearchBar(
              controller: searchController,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              hintText: 'Search...',
            ),
            const SizedBox(
              height: gap,
            ),
            // List of todo tasks
            const MyHint(title: 'Tasks:'),
            Expanded(
              child: ListView.builder(
                // show filtering todo list if todo tasks is empty and search is empty
                // else show all todo tasks
                itemCount: todoTasks.length,
                itemBuilder: (context, index) {
                  final task = todoTasks[index];

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 0,
                      right: 0,
                      bottom: 8.0,
                    ),
                    child: Dismissible(
                      key: ValueKey(task.id),
                      onDismissed: (direction) {
                        setState(() {
                          allTodoTasks
                              .removeWhere((element) => element.id == task.id);

                          if (todoTasks.isNotEmpty) {
                            todoTasks.removeWhere(
                                (element) => element.id == task.id);
                          }
                        });
                      },
                      background: Container(
                        color: myRed,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.restore_from_trash_outlined,
                            size: 50.0,
                          ),
                        ),
                      ),
                      direction: DismissDirection.startToEnd,
                      child: MyCard(task: task),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
