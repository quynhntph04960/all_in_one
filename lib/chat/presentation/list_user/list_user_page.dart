import 'package:all_in_one/base/extension/build_context_ext.dart';
import 'package:all_in_one/base/utils/common_navigator.dart';
import 'package:all_in_one/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entities.dart';
import '../chat_room/chat_room_page.dart';
import 'list_user_cubit.dart';

const linkTest = "https://wallpaperaccess.com/full/1925843.jpg";

class ListUserPage extends StatefulWidget {
  const ListUserPage({super.key});

  @override
  State<ListUserPage> createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  final _cubit = ListUserCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Người dùng"),
      ),
      body: BlocBuilder<ListUserCubit, ListFriendState>(
        bloc: _cubit,
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.listUserSystem?.length ?? 0,
            itemBuilder: (context, index) {
              print('_ListFriendPageState.build - $index');
              final user = state.listUserSystem![index];
              // final sIdFriend = accountLogin?.friends?.((e)=> e == user?.idUser);
              return InkWell(
                onTap: () {
                  if (!(accountLogin.friends?.contains(user.idUser) ?? false)) {
                    print('No add friend!!!!!');
                    return;
                  }
                  pushPage(context, ChatRoomPage(user: user));
                },
                child: _buildUser(user),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildUser(UserEntities user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
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
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.error_outline_outlined,
                  color: Colors.red,
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                user?.account ?? "",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          Visibility(
            visible: !(accountLogin.friends?.contains(user?.idUser) ?? false),
            child: InkWell(
              onTap: () => _cubit.addFriend(user),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Kết bạn",
                  style: context.themeTitleText.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
