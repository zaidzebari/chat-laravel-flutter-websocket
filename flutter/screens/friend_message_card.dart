import 'package:flutter/material.dart';
import 'package:m_socket/models/message_model.dart';

class FriendMessageCard extends StatelessWidget {
  final MessagesModel message;
  final String avatar;
  const FriendMessageCard({Key key, this.message, this.avatar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // check if it is null make global image url to display
          CircleAvatar(
            backgroundImage: NetworkImage('$avatar'),
          ),
          // Text(
          //   'img',
          //   style: TextStyle(color: Colors.white, fontSize: 13),
          // ),
          SizedBox(
            width: 12,
          ),
          Container(
            width: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color(0xFF4382D8),
                Color(0xFF2facd6),
                Color(0xFF2facd6),
                Color(0xFF2facd6),
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${message.body}',
                    style: TextStyle(color: Colors.black, fontSize: 16),
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
