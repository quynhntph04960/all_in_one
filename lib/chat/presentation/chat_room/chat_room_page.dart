import 'package:all_in_one/base/widget/input_widget.dart';
import 'package:all_in_one/domain/entities/user_entities.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final UserEntities user;
  const ChatRoomPage({super.key, required this.user});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name ?? "Chua xac dinh"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(),
          ),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InputWidget(
                    maxLength: 200,
                    minLines: 1,
                    maxLines: 3,
                    hintText: "Nhập",
                  ),
                ),
                SizedBox(width: 16),
                Icon(
                  Icons.send,
                  size: 32,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
