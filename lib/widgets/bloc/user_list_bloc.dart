import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_component_structure_practice/widgets/models/user.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  UserListBloc({@required this.httpClient}) : super(UserListState());

  final http.Client httpClient;

  @override
  Stream<UserListState> mapEventToState(
    UserListEvent event,
  ) async* {
    if (event is UserListFetched) {
      yield await _mapUserListFetchedToState(state);
    }
  }

  Future<UserListState> _mapUserListFetchedToState(UserListState state) async {
    try {
      final userList = await _fetchUsers();
      return state.copyWith(
        status: UserListStatus.success,
        userList: userList,
      );
    } on Exception {
      return state.copyWith(status: UserListStatus.failure);
    }
  }

  Future<List<User>> _fetchUsers() async {
    final response = await httpClient
        .get("https://5f8ce5d3c7aadb001605e651.mockapi.io/login");

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data
          .map(
            (dynamic rawData) => User(
              avatar: rawData['avatar'] as String,
              name: rawData['name'] as String,
              createdAt: rawData['createdAt'] as String,
            ),
          )
          .toList();
    }

    throw Exception("Error while fetching user list.");
  }
}
