import 'package:flutter/material.dart';
import 'package:m_socket/models/conversation_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ConversationCard extends StatelessWidget {
  final Function onTap;
  final ConversationModel conversation;
  const ConversationCard({
    this.onTap,
    this.conversation,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${conversation.userName}',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "${timeago.format(DateTime.parse(conversation.created))}",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
      subtitle: Text(
        '${conversation.lastMessage}',
        style: TextStyle(color: Colors.white, fontSize: 15),
        // softWrap: false,
        overflow: TextOverflow.ellipsis,
      ),
      leading:
          //this is used
          ClipOval(
        child: Image.network('${conversation.avatar}'),
      ),

      //     Text(
      //   'img',
      //   style: TextStyle(color: Colors.white, fontSize: 40),
      // ),
      //     CircleAvatar(
      //   backgroundImage: NetworkImage(
      //       'https://cdn.pixabay.com/photo/2014/07/09/10/04/man-388104_640.jpg'),
      // ),
    );
  }
}
