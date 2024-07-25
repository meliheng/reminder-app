final class Task {
  String? title;
  String? description;
  String? date;
  String? time;
  bool? isCompleted;

  Task({this.title, this.description, this.date, this.time, this.isCompleted});

  Task.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    title = json['title'];
    description = json['description'];
    date = json['date'];
    time = json['time'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['time'] = time;
    data['isCompleted'] = isCompleted;
    return data;
  }
}
