class TodoModel {
  String? title;
  String? subTitle;
  bool? status;
  String? date;
  String? id;
  double? fontSize;
  String? alignment;
  bool? pinned;

  TodoModel(
      {this.title,
      this.subTitle,
      this.status,
      this.date,
      this.id,
      this.fontSize,
      this.alignment,
      this.pinned});

  TodoModel.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    subTitle = json["subTitle"];
    status = json["status"];
    date = json["date"];
    id = json["id"];
    fontSize = json["fontSize"];
    alignment = json["alignment"];
    pinned = json["pinned"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["title"] = title;
    data["subTitle"] = subTitle;
    data["status"] = status;
    data["date"] = date;
    data["id"] = id;
    data["fontSize"] = fontSize;
    data["alignment"] = alignment;
    data["pinned"] = pinned;
    return data;
  }
}
