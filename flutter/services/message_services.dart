import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m_socket/models/message_model.dart';
import 'package:m_socket/services/base_api.dart';

class MessagesService extends BaseApi {
  Future<http.Response> getMessages(int id) async {
    return await api.httpGet('messages/$id', null);
  }

  Future<http.Response> storeMessagte(
      String message, int conversationId) async {
    print('message that you wil send is $message');
    return await api.httpPost('message',
        {'body': message, 'conversation_id': conversationId.toString()});
  }
}
