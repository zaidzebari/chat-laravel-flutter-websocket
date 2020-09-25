import 'package:flutter/material.dart';
import 'package:m_socket/models/message_model.dart';

class MyMessageCard extends StatelessWidget {
  final MessagesModel message;

  const MyMessageCard({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12, left: 33),
      decoration: BoxDecoration(
        color: Colors.purple,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(28),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${message.body}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
