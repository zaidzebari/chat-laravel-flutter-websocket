class ConversationModel {
  String userName;
  int recivierId;
  String lastMessage;
  int conversationId;
  String created;
  String avatar;

  ConversationModel(
      {this.userName,
      this.recivierId,
      this.lastMessage,
      this.conversationId,
      this.avatar,
      this.created});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    avatar = json['avatar'];
    recivierId = json['recivier_id'];
    lastMessage = json['last_message'];
    conversationId = json['conversation_id'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['avatar'] = this.avatar;
    data['recivier_id'] = this.recivierId;
    data['last_message'] = this.lastMessage;
    data['conversation_id'] = this.conversationId;
    data['created'] = this.created;
    return data;
  }
}
