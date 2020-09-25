import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:m_socket/services/base_api.dart';

class ConversationService extends BaseApi {
  Future<http.Response> getConversations() async {
    return await api.httpGet('conversations', null);
  }
}
