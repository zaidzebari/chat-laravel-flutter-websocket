class MessagesModel {
  String body;
  int userId;

  MessagesModel({this.body, this.userId});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['user_id'] = this.userId;
    return data;
  }
}
