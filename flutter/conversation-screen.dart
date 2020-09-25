import 'package:flutter/material.dart';
import 'package:m_socket/models/conversation_model.dart';
import 'package:m_socket/providers/conversation_provider.dart';
import 'package:m_socket/providers/conversations_message_provider.dart';
import 'package:m_socket/screens/chat_screen.dart';
import 'package:m_socket/screens/conversation_card_screen.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  var conversatiosn;
  @override
  void initState() {
    super.initState();
    Provider.of<CoonversationMessagesProvider>(context, listen: false)
        .getConversations();

    Provider.of<CoonversationMessagesProvider>(context, listen: false)
        .reciveMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('widget has been binding');
      // conversatiosn = Provider.of<ConversationProvider>(context, listen: false)
      //     .getConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CoonversationMessagesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Conversations'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () async {},
        ),
      ),
      body: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: provider.conversations.length,
          itemBuilder: (BuildContext contex, int index) {
            // title: Text(snapshot.data[index].name),
            return ConversationCard(
              conversation: provider.conversations[index],
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                        conversation:
                            Provider.of<CoonversationMessagesProvider>(context,
                                    listen: false)
                                .conversations[index]),
                  ),
                );

                print(Provider.of<CoonversationMessagesProvider>(context,
                        listen: false)
                    .conversations[index]
                    .conversationId);
              },
            );
          }),
    );
  }
}
