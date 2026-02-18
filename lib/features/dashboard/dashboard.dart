import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:planify/common/appbar.dart';


class TaskDashboardPage extends StatefulWidget {
  const TaskDashboardPage({Key? key}) : super(key: key);

  @override
  State<TaskDashboardPage> createState() => _TaskDashboardPageState();
}

class _TaskDashboardPageState extends State<TaskDashboardPage> {

  String selectedTaskFilter = "All";

  final List<String> taskFilters = ["All", "In Progress", "Completed", "Pending"];





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
    return ValueListenableBuilder(
      valueListenable: Hive.box("taskBox").listenable(),
      builder: (context, box, _) {

        if(box.isEmpty){
          return const Center(
            child: Text(
              "No Tasks Yet",
              style: TextStyle(color: Colors.white54),
            ),
          );
        }

        var taskList = box.values.toList();

        return ListView.builder(
          itemCount: taskList.length,
          itemBuilder: (context, index){

            var taskItem = taskList[index];

            return buildTaskCard(taskItem, index);
          },
        );
      },
    );
  }


  Widget buildTaskCard(Map taskItem, int index) {

    String priority = taskItem["priority"] ?? "LOW";
    String title = taskItem["title"] ?? "";
    String description = taskItem["description"] ?? "";
    String time = taskItem["startTime"] ?? "";
    bool isCompleted = taskItem["isCompleted"] ?? false;

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
            value: isCompleted,
            onChanged: (value){

              showDialog(
                context: context,
                builder: (context){
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xff1B1F4A),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 40,
                          ),

                          const SizedBox(height: 12),

                          const Text(
                            "Mark as Done?",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            "Do you want to complete this task?",
                            style: TextStyle(
                              color: Colors.white60,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 20),

                          Row(
                            children: [

                              Expanded(
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white.withOpacity(0.08),
                                    ),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: GestureDetector(
                                  onTap: (){

                                    var box = Hive.box("taskBox");

                                    taskItem["isCompleted"] = true;

                                    box.putAt(index, taskItem);
                                    box.deleteAt(index);

                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Task Completed ✅"),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xff4F6CFF),
                                          Color(0xff8F3CFF)
                                        ],
                                      ),
                                    ),
                                    child: const Text(
                                      "Done",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  );

                },
              );
            },

          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    buildStatusTag(isCompleted),

                    const SizedBox(width: 10),
                    Text(time,
                        style: const TextStyle(color: Colors.white54))
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),

                Text(
                  description,
                  style: const TextStyle(color: Colors.white60),
                ),

              ],

            ),

          ),
          Column(
            children: [

              GestureDetector(
                onTap: (){
                  editTask(taskItem, index);
                },
                child: const Icon(Icons.edit, color: Colors.white60),
              ),

              const SizedBox(height: 10),

              GestureDetector(
                onTap: (){
                  deleteTask(index);
                },
                child: const Icon(Icons.delete_outline, color: Colors.red),
              ),

            ],
          )

        ],
      ),
    );
  }


  void editTask(Map taskItem, int index){

    TextEditingController titleController =
    TextEditingController(text: taskItem["title"]);

    TextEditingController descController =
    TextEditingController(text: taskItem["description"]);

    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text("Edit Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: "Title",
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: descController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
            ],
          ),

          actions: [

            TextButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: (){

                var box = Hive.box("taskBox");

                Map updatedTask = {
                  ...taskItem,
                  "title": titleController.text,
                  "description": descController.text,
                };

                box.putAt(index, updatedTask);

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Task Updated ✏"),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }


  void deleteTask(int index){

    var box = Hive.box("taskBox");

    box.deleteAt(index);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Task Deleted 🗑"),
        backgroundColor: Colors.red,
      ),
    );
  }


  Widget buildStatusTag(bool isCompleted) {

    String status = isCompleted ? "Completed" : "Pending";

    Color tagColor = isCompleted
        ? Colors.green
        : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: tagColor,
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }







}
