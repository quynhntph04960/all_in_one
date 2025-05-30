import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

const linkTest = "https://wallpaperaccess.com/full/1925843.jpg";

class ListFriendPage extends StatefulWidget {
  const ListFriendPage({super.key});

  @override
  State<ListFriendPage> createState() => _ListFriendPageState();
}

class _ListFriendPageState extends State<ListFriendPage> {
  List<User> listUsers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final firebase = FirebaseDatabase.instance.ref();
    final db = firebase.child("chat/list_user");
    // final db3 = FirebaseDatabase.instance.ref().child("chat/message").set({});
    db.onValue.listen((event) {
      final snapshot = event.snapshot.value as Map<dynamic, dynamic>;
      snapshot.forEach((key, value) {
        listUsers.add(User(
          idUser: key,
          name: value['name'],
          avatar: value['avatar'],
        ));
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Người dùng"),
      ),
      body: ListView.builder(
        itemCount: listUsers.length,
        itemBuilder: (context, index) {
          final user = listUsers[index];

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(500),
                  child: Image.network(
                    linkTest,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    user.name ?? "",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class User {
  String? idUser;
  String? name;
  String? avatar;

  User({required this.name, required this.avatar, required this.idUser});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
