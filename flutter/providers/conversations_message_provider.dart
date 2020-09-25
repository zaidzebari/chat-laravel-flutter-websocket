import 'dart:convert';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:m_socket/models/conversation_model.dart';
import 'package:m_socket/models/message_model.dart';
import 'package:m_socket/providers/base_provider.dart';
import 'package:m_socket/services/conversation_service.dart';
import 'package:m_socket/services/message_services.dart';

class CoonversationMessagesProvider extends BaseProvider {
  MessagesService _messagesService = MessagesService();
  List<MessagesModel> _messages = List();
  List<MessagesModel> get messages => _messages;

  ConversationService _conversationService = ConversationService();
  List<ConversationModel> _conversations = List();
  List<ConversationModel> get conversations => _conversations;

  FlutterPusher pusher;
  Echo echo;
  String token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiOWM0MzFjMDRjMmM4NTJkM2Y3OWQ3MGRhZmEwYzA4ZGZhN2VmOGI3NzY1YjZiNTA4MjgzYmY1OWIzNWI4N2I1ODYxMGU3OWNhNmQwMjYwNDIiLCJpYXQiOjE2MDA5NTc1NjMsIm5iZiI6MTYwMDk1NzU2MywiZXhwIjoxNjMyNDkzNTYzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.Ee-Rm-V_IH365dZ7RYNp77D7UJycXCEGd1yHv8DaKSqg5iM006YWLUi3GIDPAM-dA0okjdMxrdUtomVrsQGjUN2nEzUsojVdEDNuqTA4JMMhtJHEtTvSnubsdi7vWz3QIM9PpT4yn6OnOqxTiYQNGYpbuokaRof6-aIwndl11yTNPSj8tBvgmBfrIpGjxHEmEzio_mpVH7tr4_SCN1mIlDcdxO91ZNO6_OgAOkJNumXnDfoRatN7T6Js_NlU6mGHjTWUdAL36FUzguOPgv4x3L2uIO3dRcU8cI0lQzQ9vb_xWTnVTz4K2xbBxsgCYiadqnoKhsiHkjw5kAEoN0we0Dm9aFSUJ4NXEWe0juCwYtm3J4aIe3sdodneSVv8svSa6KsDPZF35Vq6gNJKBno8ZKL8qm0S8dhbYn18VCmsr1Gqcj2fAizJubdeVLOs2bJBw2rTKBoLUAscjvTLiEcfDhrGcYcuLvhVWLICTSYejj7BneB3LlLp8o3Ov4KaZ_hwiko7VWyOacCnwizKyh6xXNKh7gF4n8mwO4qxCEoLHsKrePacXZ_PBOLke3tI8VoHjuEqijEnEEebMHYfHyF0TZAHGDGQ1QeKJfjDAcjCc_i7GvJ3edHYcyuen-BtU_o36gEuFwZyXPhnPwDWaD6luvncsde7nXUp9jPwBA5mZUA";

  Future<List<MessagesModel>> getMessages(int id) async {
    _messages = List(); //refresh when we call it again becouse of provider
    print('called getMessages');
    var response = await _messagesService.getMessages(id);
    // print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['data'].forEach(
          (conversaion) => _messages.add(MessagesModel.fromJson(conversaion)));
      print(response.body);
      notifyListeners();
    }
    return _messages;
  }

  Future<MessagesModel> storeMessage(String body, int conversationId) async {
    var response = await _messagesService.storeMessagte(body, conversationId);
    print('store message called ${response.body}');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['body']);

      MessagesModel message = MessagesModel();
      message.body = data['body'];
      message.userId = data['user_id'];
      // _messages.add(message);

      for (int i = 0; i < conversations.length; i++) {
        print(conversations[i].conversationId);
        if (conversations[i].conversationId == conversationId) {
          conversations[i].lastMessage = body;
          conversations[i].created = data['created_at'];
        }
      }

      notifyListeners();
      return message;
      // ConversationModel.fromJson(data['data']);
    } else {
      print('error happen while calling to storeMessage in the provider');
      return null;
    }
  }

  Future<List<ConversationModel>> getConversations() async {
    _conversations = List(); //refresh when we call it again becouse of provider
    print('called getConversations');
    var response = await _conversationService.getConversations();
    // print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data['data'].forEach((conversaion) =>
          _conversations.add(ConversationModel.fromJson(conversaion)));
      print(response.body);
      notifyListeners();
    }
    return _conversations;
  }

  void reciveMessage() {
    // echo.disconnect();
    PusherOptions options = PusherOptions(
      host: '192.168.1.16',
      port: 6001,
      cluster: 'mt1',
      encrypted: false,
      auth: PusherAuth(
        "http://192.168.1.16/web/socket/public/broadcasting/auth",
        headers: {
          'Authorization': "Bearer $token",
          'Content-Type': 'application/json',
        },
      ),
    );

    try {
      pusher = FlutterPusher('ABCDEFG', options, enableLogging: true);
    } catch (e) {
      print(e.errMsg());
    }
    echo = new Echo({
      'broadcaster': 'pusher',
      'client': pusher,
    });

    echo.private('home').listen('NewMessage', (event) {
      var data = jsonDecode(event['message']);
      print(data['body']);

      MessagesModel message = MessagesModel();
      message.body = data['body'];
      message.userId = data['user_id'];
      _messages.add(message);

      for (int i = 0; i < conversations.length; i++) {
        print(data['conversation_id'] +
            "   " +
            conversations[i].conversationId.toString());
        if (conversations[i].conversationId ==
            int.parse(data['conversation_id'])) {
          conversations[i].lastMessage = data['body'];
          conversations[i].created = data['created_at'];
          print('yes it is equal');
        }
      }
      print('nitifiyed');
      notifyListeners();

      // print('this is event text ' + event['message']['0']['body']);
    });
  }
}
