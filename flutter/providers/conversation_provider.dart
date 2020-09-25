// import 'dart:convert';
// import 'package:m_socket/models/conversation_model.dart';
// import 'package:m_socket/providers/base_provider.dart';
// import 'package:m_socket/services/conversation_service.dart';

// class ConversationProvider extends BaseProvider {
//   // ConversationService _conversationService = ConversationService();
//   // List<ConversationModel> _conversations = List();
//   // List<ConversationModel> get conversations => _conversations;

//   // Future<List<ConversationModel>> getConversations() async {
//   //   _conversations = List(); //refresh when we call it again becouse of provider
//   //   print('called getConversations');
//   //   var response = await _conversationService.getConversations();
//   //   // print(response.body);
//   //   if (response.statusCode == 200) {
//   //     var data = jsonDecode(response.body);
//   //     data['data'].forEach((conversaion) =>
//   //         _conversations.add(ConversationModel.fromJson(conversaion)));
//   //     print(response.body);
//   //     notifyListeners();
//   //   }
//   //   return _conversations;
//   // }

//   // Future<MessageModel> storeMessage(MessageModel message) async {
//   //   setBusy(true);
//   //   var response = await _conversationService.storeMessagte(message);
//   //   if (response.statusCode == 201) {
//   //     var data = jsonDecode(response.body);
//   //     //just added to conversation and then notifilistener
//   //     // print(response.body);
//   //     // notifyListeners();
//   //     setBusy(false);
//   //     return MessageModel.fromJson(data['data']);
//   //   } else {
//   //     setBusy(false);
//   //     return null;
//   //   }
//   // }
// }
