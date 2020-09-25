// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:m_socket/models/conversation_model.dart';
// import 'package:m_socket/models/message_model.dart';
// import 'package:m_socket/providers/base_provider.dart';
// import 'package:m_socket/services/message_services.dart';

// class MessageProvider extends BaseProvider {
//   MessagesService _messagesService = MessagesService();
//   List<MessagesModel> _messages = List();
//   List<MessagesModel> get messages => _messages;

//   Future<List<MessagesModel>> getMessages(int id) async {
//     _messages = List(); //refresh when we call it again becouse of provider
//     print('called getMessages');
//     var response = await _messagesService.getMessages(id);
//     // print(response.body);
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       data['data'].forEach(
//           (conversaion) => _messages.add(MessagesModel.fromJson(conversaion)));
//       print(response.body);
//       notifyListeners();
//     }
//     return _messages;
//   }

//   Future<MessagesModel> storeMessage(String body, int conversationId) async {
//     var response = await _messagesService.storeMessagte(body, conversationId);
//     print('store message called ${response.body}');
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       print(data['body']);
//       MessagesModel message = MessagesModel();
//       message.body = data['body'];
//       message.userId = data['user_id'];
//       _messages.add(message);
//       notifyListeners();
//       return message;
//       // ConversationModel.fromJson(data['data']);
//     } else {
//       print('error happen while calling to storeMessage in the provider');
//       return null;
//     }
//   }
// }
