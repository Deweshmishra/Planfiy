class TaskModel {

  String title;
  String description;
  String date;
  String startTime;
  String endTime;
  String priority;
  bool reminder;
  bool isCompleted;

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.priority,
    required this.reminder,
    required this.isCompleted,
  });

  /// JSON SAVE
  Map<String,dynamic> toJson(){
    return{
      "title":title,
      "description":description,
      "date":date,
      "startTime":startTime,
      "endTime":endTime,
      "priority":priority,
      "reminder":reminder,
      "isCompleted":isCompleted,
    };
  }

  /// JSON READ
  factory TaskModel.fromJson(Map json){
    return TaskModel(
      title: json["title"],
      description: json["description"],
      date: json["date"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      priority: json["priority"],
      reminder: json["reminder"],
      isCompleted: json["isCompleted"],
    );
  }
}
