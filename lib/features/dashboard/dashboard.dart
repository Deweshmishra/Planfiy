import 'package:flutter/material.dart';
import 'package:planify/common/appbar.dart';
import 'package:planify/features/addtask/add_task_page.dart';
import 'package:planify/features/profile/profile_page.dart';

class TaskDashboardPage extends StatefulWidget {
  const TaskDashboardPage({Key? key}) : super(key: key);

  @override
  State<TaskDashboardPage> createState() => _TaskDashboardPageState();
}

class _TaskDashboardPageState extends State<TaskDashboardPage> {

  String selectedTaskFilter = "All";

  final List<String> taskFilters = ["All", "In Progress", "Completed", "Pending"];

  final List<Map<String, dynamic>> todayTaskList = [
    {
      "priority": "HIGH",
      "time": "10:00 AM",
      "title": "Review Project Proposal",
      "subtitle": "Check the updated Q3 budget slides.",
      "isCompleted": false
    },
    {
      "priority": "MEDIUM",
      "time": "01:30 PM",
      "title": "Design System Audit",
      "subtitle": "Sync tokens with development team.",
      "isCompleted": false
    },
    {
      "priority": "LOW",
      "time": "Done",
      "title": "Stand up Meeting",
      "subtitle": "Daily sync with the DocuScan team.",
      "isCompleted": true
    },
    {
      "priority": "HIGH",
      "time": "04:00 PM",
      "title": "Client Final Handover",
      "subtitle": "Send all assets and documentation.",
      "isCompleted": false
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D1333),
      // floatingActionButton: buildAddTaskFloatingButton(),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonAppBar(
                isHome: true,
              ),
              const SizedBox(height: 20),
              buildTaskFilterChips(),
              const SizedBox(height: 20),
              buildTodayTaskTitleRow(),
              const SizedBox(height: 10),
              Expanded(child: buildTodayTaskList()),
            ],
          ),
        ),
      ),
    );
  }



  Widget buildTaskFilterChips() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: taskFilters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ChoiceChip(
              label: Text(taskFilters[index]),
              selected: selectedTaskFilter == taskFilters[index],
              onSelected: (value) {
                setState(() {
                  selectedTaskFilter = taskFilters[index];
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildTodayTaskTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          "Today's Tasks",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text("See All", style: TextStyle(color: Colors.blue))
      ],
    );
  }

  Widget buildTodayTaskList() {
    return ListView.builder(
      itemCount: todayTaskList.length,
      itemBuilder: (context, index) {
        final taskItem = todayTaskList[index];
        return buildTaskCard(taskItem);
      },
    );
  }

  Widget buildTaskCard(Map<String, dynamic> taskItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white10,
      ),
      child: Row(
        children: [
          Checkbox(
            value: taskItem["isCompleted"],
            onChanged: (value) {
              setState(() {
                taskItem["isCompleted"] = value;
              });
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    buildPriorityTag(taskItem["priority"]),
                    const SizedBox(width: 10),
                    Text(taskItem["time"],
                        style: const TextStyle(color: Colors.white54))
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  taskItem["title"],
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  taskItem["subtitle"],
                  style: const TextStyle(color: Colors.white60),
                )
              ],
            ),
          ),
          Column(
            children: const [
              Icon(Icons.edit, color: Colors.white60),
              SizedBox(height: 10),
              Icon(Icons.delete_outline, color: Colors.white60)
            ],
          )
        ],
      ),
    );
  }

  Widget buildPriorityTag(String priority) {
    Color tagColor = Colors.green;

    if (priority == "HIGH") tagColor = Colors.red;
    if (priority == "MEDIUM") tagColor = Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: tagColor),
      child: Text(priority,
          style: const TextStyle(color: Colors.white, fontSize: 10)),
    );
  }
  // Widget buildAddTaskFloatingButton() {
  //   return FloatingActionButton(
  //     onPressed: () async {
  //
  //       final newTask = await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const AddTaskPage(),
  //         ),
  //       );
  //
  //       if (newTask != null) {
  //         setState(() {
  //           todayTaskList.add(newTask);
  //         });
  //       }
  //     },
  //     backgroundColor: Colors.blueAccent,
  //     elevation: 6,
  //     shape: const CircleBorder(),
  //     child: const Icon(
  //       Icons.add,
  //       color: Colors.white,
  //       size: 30,
  //     ),
  //   );
  // }





}
