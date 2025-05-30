import 'package:all_in_one/base/utils/common_function.dart';
import 'package:all_in_one/di/di.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/service/firebase_service.dart';
import '../../../domain/entities/user_entities.dart';

class ListUserCubit extends Cubit<ListFriendState> {
  ListUserCubit() : super(const ListFriendState());

  Future initialize() async {
    final list = await firebaseService.getListUserSystem();
    list.removeWhere((e) => e.idUser == accountLogin.idUser);
    emit(
      state.copyWith(
        listUserSystem: list,
      ),
    );
  }

  Future addFriend(UserEntities? data) async {
    if (isNullOrEmpty(data?.friends)) {
      data?.friends = [];
    }
    data?.friends?.add(accountLogin.idUser!);

    if (isNullOrEmpty(accountLogin.friends)) {
      accountLogin.friends = [];
    }
    accountLogin.friends?.add(data!.idUser!);

    data?.friends?.toSet().toList();
    accountLogin.friends?.toSet().toList();

    await firebaseService.createAccount(accountLogin,
        isUpdate: true, keyDoc: accountLogin.idUser);
    await firebaseService.createAccount(data!,
        isUpdate: true, keyDoc: data.idUser);
    emit(ListFriendState(listUserSystem: state.listUserSystem));
  }
}

class ListFriendState extends Equatable {
  // danh sách người dụng trong hệ thống
  final List<UserEntities>? listUserSystem;

  const ListFriendState({
    this.listUserSystem,
  });

  @override
  List<Object?> get props => [
        listUserSystem,
      ];

  ListFriendState copyWith({
    List<UserEntities>? listUserSystem,
  }) {
    return ListFriendState(
      listUserSystem: listUserSystem ?? this.listUserSystem,
    );
  }
}
