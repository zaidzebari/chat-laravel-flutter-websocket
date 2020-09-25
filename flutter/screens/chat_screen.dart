import 'package:flutter/material.dart';
import 'package:m_socket/models/conversation_model.dart';
import 'package:m_socket/models/message_model.dart';
import 'package:m_socket/providers/conversation_provider.dart';
import 'package:m_socket/providers/conversations_message_provider.dart';
import 'package:m_socket/providers/message_provider.dart';
import 'package:m_socket/screens/conversation_card_screen.dart';
import 'package:m_socket/screens/friend_message_card.dart';
import 'package:m_socket/screens/my_message_card.dart';

import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ConversationModel conversation;
  const ChatScreen({Key key, this.conversation});
  @override
  _ChatScreenState createState() => _ChatScreenState(this.conversation);
}

class _ChatScreenState extends State<ChatScreen> {
  final ConversationModel conversation;
  List<MessagesModel> message;
  TextEditingController messageTextEditingController = TextEditingController();
  _ChatScreenState(this.conversation);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<CoonversationMessagesProvider>(context, listen: false)
        .getMessages(conversation.conversationId);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //  getMessage();
      _scrollController
          .jumpTo(_scrollController.position.minScrollExtent + 100);
    });
  }

  // getMessage() async {
  //   message = ;
  //   // return message;
  // }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CoonversationMessagesProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('${conversation.userName}'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  // reverse: true,
                  // physics: ScrollPhysics(),
                  padding: EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: provider.messages.length,
                  itemBuilder: (BuildContext contex, int index) {
                    // title: Text(snapshot.data[index].name),

                    return Provider.of<CoonversationMessagesProvider>(contex,
                                    listen: false)
                                .messages[index]
                                .userId ==
                            conversation.recivierId
                        ? FriendMessageCard(
                            message: provider.messages[index],
                            avatar: conversation.avatar,
                          )
                        : MyMessageCard(
                            message: provider.messages[index],
                          );
                  }

                  //  },
                  )),
          Container(
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.all(0),
            // color: Colors.red,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: TextField(
                  onSubmitted: (v) {
                    print('submitet');
                  },
                  controller: messageTextEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type message here..',
                    hintStyle: TextStyle(),
                  ),
                )),
                // Provider.of<ConversationProvider>(context).busy
                //     ? CircularProgressIndicator()
                //     :
                //make set busy here if it is busy try to display circuler here instead of button to avoid send multiple times
                InkWell(
                  onTap: () async {
                    // FocusScope.of(context).requestFocus(FocusNode());
                    if (messageTextEditingController.text.trim().isEmpty)
                      return;
                    else {
                      var response =
                          await Provider.of<CoonversationMessagesProvider>(
                                  context,
                                  listen: false)
                              .storeMessage(
                                  messageTextEditingController.text.trim(),
                                  conversation.conversationId);
                      messageTextEditingController.clear();

                      if (response != null) {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      } else {
                        print('message not sended');
                      }
                    }

                    // message.body =
                    //     messageTextEditingController.text.trim();
                    // var messageStored =
                    //     await Provider.of<ConversationProvider>(context)
                    //         .storeMessage(message);
                    // if (messageStored != null) {
                    //   //if not added try to use setstate()
                    //   conversation.messages.add(messageStored);
                    //   messageTextEditingController.clear();
                    //   _scrollController.jumpTo(
                    //       _scrollController.position.minScrollExtent +
                    //           23);
                    // }
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFF4382D8),
                              Color(0xFF2facd6),
                              Color(0xFF2facd6),
                              Color(0xFF2facd6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
