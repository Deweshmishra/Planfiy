import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendareState();
}

class _CalendareState extends State<Calendar> {

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // ================= TAB =================

  int selectedTabIndex = 2;

  Widget buildTab(String title, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selectedTabIndex == index
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // ================= CALENDAR =================

  Widget buildCalendar() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: const CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.deepPurple,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(color: Colors.white),
        weekendTextStyle: TextStyle(color: Colors.white),
      ),
      headerVisible: false,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white54),
        weekendStyle: TextStyle(color: Colors.white54),
      ),
    );
  }

  // ================= MAIN =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F172A),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0D1333),
              Color(0xff1B1F4A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text(
                  "Calendar",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          buildTab("Daily", 0),
                          buildTab("Weekly", 1),
                          buildTab("Monthly", 2),
                        ],
                      ),

                      const SizedBox(height: 20),

                      buildCalendar(),

                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box("taskBox").listenable(),
                    builder: (context, box, _) {

                      var allTasks = box.values.toList();

                      // ⭐ FILTER DATE WISE
                      var filteredTasks = allTasks.where((task){

                        DateTime taskDate = DateTime.parse(task["date"]);

                        return isSameDay(taskDate, _selectedDay);

                      }).toList();

                      if(filteredTasks.isEmpty){
                        return const Center(
                          child: Text(
                            "No Tasks for Selected Date",
                            style: TextStyle(color: Colors.white54),
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index){

                          var task = filteredTasks[index];

                          String title = task["title"] ?? "";
                          String time = task["startTime"] ?? "";
                          String priority = task["priority"] ?? "";

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              title: Text(
                                title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                "$time  |  $priority",
                                style: const TextStyle(color: Colors.white54),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),


              ],
            ),
          ),
        ),
      ),

    );
  }
}
