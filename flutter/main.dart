import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:m_socket/conversation-screen.dart';
import 'package:m_socket/providers/conversation_provider.dart';
import 'package:m_socket/providers/conversations_message_provider.dart';
import 'package:m_socket/providers/message_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // providers:providers,
      providers: [
        //
        //  Provider<ConversationProvider>(create: (_) => ConversationProvider()),
        ChangeNotifierProvider(
          create: (context) => CoonversationMessagesProvider(),
        ),
        // ChangeNotifierProvider(
        //   create: (context) => MessageProvider(),
        // ),
      ],
      child: StartApp(),
    );
  }
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Laravel Laravel Websocket',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ConversationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   FlutterPusher pusher;
//   Echo echo;
//   List<Message> message = [];
// //eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiZjU5ZjMzNWQzZmI4ZGFkMjZlMDBkZGVkMjg1ZDNlZGJkZjIzZDU0ZTljZmM1YjBmYzU4YjhlZmQ3NjAwNmIxMjQ2NGYwMTc1YTE1OWExMDQiLCJpYXQiOjE2MDAwMjYyOTksIm5iZiI6MTYwMDAyNjI5OSwiZXhwIjoxNjMxNTYyMjk5LCJzdWIiOiI1Iiwic2NvcGVzIjpbXX0.VBQUudip1A2r5qfMGYDtqIWJOY4t7aydA_-9Fodb5AboU22KCEdNoCFfGYeGUS_SydyRuNz385C8x5GrIMtRFU35F7soMTFz7vN-PT9DWYBexPL0Yf6dC3aiMXgEciNT2IXXieUbqmwadEBKyWF2YKbRY4e_gD1r0dzqim7G5acgeqeh5PbkIj-FaIFEUOj4Zfo4ibdQcvu7LV0XVLHyHbWrr5HkyEXaodrG6uyp9WNjPGsRbRGx52WgsdWOgY_hyC4m9PFRBoEwu0oi-_qnqjdmnMQlvq-awh41Sa96VaBvdm4ulawKzT0H8h4_yh4LrphirgeVg5rlgFwtzWrJk0uRwFPKQviORm9yPvjwlTHgMqHkXR5aT2hQhMcvQkhM0uxy_qSGc6CvEPT35sGoO7AyF1N0OfhDzlqwI_dNO1dzf0GRg-4yh5YZ0qGtiHAQqY6EdEpq0h0lFN8CiZdxbBniQ9mp4iO0SPKND5qJPqBZMVLfjaputOebbVg3bs_oQp2qMQxxZQfnd79KBcFdYEIgIcdqDLZzZWdr2Bjobevg4PZr62OlHge6u3lU2jBr7aCdzR22HC_fpls8ZKIazY_pwM9MfuvWZhMQ_3HQzwQDluTmI4jE9rq61d2vysrd7DpB_TKGKi1P2xXFlDTWCpIeWRsCMLywztDQxRxU4vY
//   String token =
//       "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiNjZkNDNmY2IwYzVkYTBjZDVhZDFhYjgwODNkODMxZTRmOGRmYmFmNmE3NmNkOTdhMWYzYzhkNmViNWMxZWI1NTg5YzQ4ODAyMDhkMDE2ZmMiLCJpYXQiOjE2MDA4ODU0ODEsIm5iZiI6MTYwMDg4NTQ4MSwiZXhwIjoxNjMyNDIxNDgxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.WCOyiuPAwDKHd7lTVjRf6z0RCePC0J2A1X_ratHOBG2TXPV3P2tW9Ee6Mvu3sBlpq1JYs_LzoVzi8TvQW38HbdhpL4BKZ5cFcSejEii4gazinkhkol0xkKwsWWE5_O7UFDl2epeWhueP8LfpXvKq6aJtshS6xVx4iK7xm62iLzDtGINU2_oK_iZJHeqn4ZcaVTl0uHhrXbMP6tuQyfmHF7RFmSRqkhsA-X6ZUaashJju_JEb3XVG_Ni8Sj6b2Pufv5AGGuyYhMCLUfxyF-FyXjTDXRPPARC9StCgeBgjiGKzcDQSA-QZgk6UX9Udz6onk2yL7ZPv3zu6YSIJo9hieOeInGLsCfZS-zYD4hAAcJ4RhKtQZvX6I0ZvoT70QpAqOdUp5WJeGSt_j5reTDfldNJ_yPrEVT2nkMCGQQpsU3bld7WJ2Du976I101ET8fmeSXoExfV9_gDX0hjMDKs8iLNFj5NipXaTlGOTNqjF32zBm-hdbj02ASb6URdLYq2HZU9AhfyPAVA_w1tU9QFs7B45txUHAgdthk-G_mXMFyBeaXsp8xRPynd7u4qfCIEu8bFlfjpv45_RA8jbZaR3WqmQ71WTkCv0-OrB6kyt4RYyTJ6poK2EqgeYmD3iyaOrmvAHNZpGEo6gVkVQk9b7RtT1JjIupwPiW2fQCzlgQeY";
//   void initSocket() {
//     print('initiating Socket....');
//     PusherOptions options = PusherOptions(
//       host: '192.168.1.16',
//       port: 6001,
//       cluster: 'mt1',
//       encrypted: false,
//       auth: PusherAuth(
//         "http://192.168.1.16/web/socket/public/broadcasting/auth",
//         headers: {
//           'Authorization': "Bearer $token",
//           'Content-Type': 'application/json',
//         },
//       ),
//     );

//     try {
//       pusher = FlutterPusher('ABCDEFG', options, enableLogging: true);
//     } catch (e) {
//       print(e.errMsg());
//     }
//     echo = new Echo({
//       'broadcaster': 'pusher',
//       'client': pusher,
//     });
//     //"https://192.168.1.22/broadcasting/auth"

//     echo.private('home').listen('NewMessage', (event) {
//       print('this is event text ' + event['message'].toString());

//       message.add(Message(event['message'].toString()));
//       _messageController.add(event['message'].toString());
//     });
//   } //http://192.168.1.22/web/socket/public/broadcasting/auth

//   @override
//   void dispose() {
//     echo.disconnect();

//     super.dispose();
//   }

//   StreamController<String> _messageController;

//   @override
//   void initState() {
//     super.initState();
//     _messageController = new StreamController();
//   }

//   reciveMessage(String message) {
//     print(message);

//     setState(() {
//       _messageController.add(message);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: StreamBuilder(
//         stream: _messageController.stream,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           print('Has error: ${snapshot.hasError}');
//           print('Has data: ${snapshot.hasData}');
//           print('Snapshot Data ${snapshot.data}');

//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               return Center(
//                 child: Text('None'),
//               );
//               break;
//             case ConnectionState.waiting:
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//               break;
//             case ConnectionState.active:
//               return Center(
//                 child: Text(
//                   snapshot.data == null ? 'Null' : snapshot.data,
//                 ),
//               );
//               break;
//             case ConnectionState.done:
//               print('Done is fucking here ${snapshot.data}');
//               if (snapshot.hasData) {
//                 return Center(
//                   child: Text(
//                     snapshot.data.fname == null ? 'Null' : snapshot.data,
//                     style: Theme.of(context).textTheme.display1,
//                   ),
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Has Error');
//               } else {
//                 return Text('Error');
//               }
//               break;
//           }
//           return Text('Non in Switch');
//         },
//       ),

//       //  ListView.builder(
//       //     physics: ScrollPhysics(),
//       //     shrinkWrap: true,
//       //     itemCount: message.length,
//       //     itemBuilder: (BuildContext contex, int index) {
//       //       return ListTile(
//       //         title: Text(
//       //           message[index].message.toString(),
//       //           style: TextStyle(fontSize: 22),
//       //         ),
//       //       );
//       //     }),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () => initSocket(),
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// class Message {
//   String message;
//   Message(this.message);
// }
