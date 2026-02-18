import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planify/common/appbar.dart';
import 'package:planify/features/addtask/model/task_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  String selectedPriority = "Medium";
  bool isReminderOn = true;


  // ================= DATE PICKER =================
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  // ================= TIME PICKER =================
  Future<void> pickStartTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null) {
      setState(() => startTime = picked);
    }
  }

  Future<void> pickEndTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null) {
      setState(() => endTime = picked);
    }
  }

  // ================= CREATE TASK =================
  void createTask() async {

    var box = Hive.box("taskBox");

    TaskModel task = TaskModel(
      title: titleController.text,
      description: descriptionController.text,
      date: selectedDate.toString(),
      startTime: startTime.format(context),
      endTime: endTime.format(context),
      priority: selectedPriority,
      reminder: isReminderOn,
      isCompleted: false,
    );

    /// SAVE AS JSON
    await box.add(task.toJson());

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xff0D1333),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0D1333), Color(0xff1B1F4A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              CommonAppBar(
                title: "Add New Task",
              ),
              buildGlassMainCard(),

            ],
          ),
        ),
      ),
    );
  }


  Widget buildGlassMainCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCapsuleSingleLine("TASK TITLE", titleController),
          const SizedBox(height: 18),
          buildCapsuleDescription("DESCRIPTION", descriptionController),
          const SizedBox(height: 18),

          buildDateStrip(),
          const SizedBox(height: 18),

          buildTimeRow(),
          const SizedBox(height: 18),

          buildPriorityPills(),
          const SizedBox(height: 18),

          buildReminderRow(),
          const SizedBox(height: 24),

          buildGradientCreateButton(),

        ],
      ),
    );
  }

  Widget buildCapsuleSingleLine(
      String label,
      TextEditingController controller) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        Text(label,
            style: const TextStyle(
                color: Colors.white54,
                fontSize: 12)),

        const SizedBox(height: 6),

        Container(
          height: 52,
          padding:
          const EdgeInsets.symmetric(
              horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius:
            BorderRadius.circular(10),
          ),

          child: TextField(
            controller: controller,
            maxLines: 1, // ⭐ ONLY ONE LINE
            textAlignVertical:
            TextAlignVertical.center,
            style: const TextStyle(
                color: Colors.white),

            decoration:
            const InputDecoration(
              border:
              InputBorder.none,
              hintText:
              "Enter title...",
              hintStyle:
              TextStyle(
                  color:
                  Colors.white38),
            ),
          ),
        ),
      ],
    );
  }


  Widget buildCapsuleDescription(
      String label,
      TextEditingController controller) {

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        Text(label,
            style: const TextStyle(
                color: Colors.white54,
                fontSize: 12)),

        const SizedBox(height: 6),

        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius:
            BorderRadius.circular(10),
          ),

          child: TextField(
            controller: controller,
            maxLines: 4,
            style: const TextStyle(
                color: Colors.white),

            decoration:
            const InputDecoration(
              border:
              InputBorder.none,
              hintText:
              "Enter description...",
              hintStyle:
              TextStyle(
                  color:
                  Colors.white38),
            ),
          ),
        ),
      ],
    );
  }



  Widget buildDateStrip() {

    DateTime startOfWeek =
    selectedDate.subtract(
      Duration(days: selectedDate.weekday - 1),
    );

    List<DateTime> weekDates =
    List.generate(7,
            (i) => startOfWeek.add(Duration(days: i)));

    List<String> weekDays =
    ["M","T","W","T","F","S","S"];

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        const Text(
          "SELECT DUE DATE",
          style:
          TextStyle(color: Colors.white54),
        ),

        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekDates.map((date){

            bool selected =
                selectedDate.day == date.day &&
                    selectedDate.month == date.month &&
                    selectedDate.year == date.year;

            bool isSunday = date.weekday == DateTime.sunday;

            String dayLetter =
            ["M","T","W","T","F","S","S"][date.weekday - 1];

            return GestureDetector(
              onTap:(){
                setState(() {
                  selectedDate = date;
                });
              },

              child: Column(
                children: [

                  /// DAY TEXT
                  Text(
                    dayLetter,
                    style: TextStyle(
                      color: isSunday
                          ? Colors.green   // Sunday green
                          : Colors.white54,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// DATE CIRCLE
                  Container(
                    height: 38,
                    width: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: selected
                          ? const LinearGradient(
                        colors:[
                          Color(0xff4F6CFF),
                          Color(0xff3C9CFF),
                        ],
                      )
                          : null,
                    ),
                    child: Text(
                      "${date.day}",
                      style: TextStyle(
                        color: selected
                            ? Colors.white
                            : isSunday
                            ? Colors.green
                            : Colors.white54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );

          }).toList(),
        ),

      ],
    );
  }


  Widget buildTimeCapsule(TimeOfDay time) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white.withOpacity(0.06),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time,
              color: Colors.white54, size: 18),
          const SizedBox(width: 6),
          Text(
            time.format(context),
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Widget buildTimeRow() {
    return Row(
      children: [
        Expanded(child: buildTimeCapsule(startTime)),
        const SizedBox(width: 10),
        Expanded(child: buildTimeCapsule(endTime)),
      ],
    );
  }


  Widget buildPriorityPills() {

    List<String> p = ["Low","Medium","High"];

    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: p.map((e) {

        bool selected = selectedPriority == e;

        return GestureDetector(
          onTap: (){
            setState(() {
              selectedPriority = e;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: selected
                  ? const LinearGradient(
                  colors: [
                    Color(0xff4F6CFF),
                    Color(0xff8F3CFF)
                  ])
                  : null,
              color: selected
                  ? null
                  : Colors.white.withOpacity(0.06),
            ),
            child: Text(
              e,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.white54,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }


  Widget buildReminderRow() {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.notifications_none,
                color: Colors.blue),
            SizedBox(width: 8),
            Text("Reminder",
                style: TextStyle(color: Colors.white)),
          ],
        ),
        Switch(
          value: isReminderOn,
          onChanged: (v){
            setState(() {
              isReminderOn = v;
            });
          },
        )
      ],
    );
  }


  Widget buildGradientCreateButton() {
    return GestureDetector(
      onTap: createTask,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xff4F6CFF),
              Color(0xff8F3CFF)
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Create Task →",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16),
          ),
        ),
      ),
    );
  }

}
