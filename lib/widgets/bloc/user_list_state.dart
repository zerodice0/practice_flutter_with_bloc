part of 'user_list_bloc.dart';

enum UserListStatus { initial, success, failure }

@immutable
class UserListState extends Equatable {
  final List<User> userList;
  final UserListStatus status;

  UserListState({
    this.userList = const <User>[],
    this.status = UserListStatus.initial,
  });

  UserListState copyWith({
    List<User> userList,
    UserListStatus status,
  }) =>
      UserListState(
        userList: userList ?? this.userList,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [status, userList];
}
