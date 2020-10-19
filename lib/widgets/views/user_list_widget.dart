import 'package:flutter/material.dart';
import 'package:flutter_component_structure_practice/components/namecard.dart';
import 'package:flutter_component_structure_practice/widgets/bloc/user_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  UserListBloc _userListBloc;

  @override
  void initState() {
    super.initState();
    _userListBloc = context.bloc<UserListBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserListBloc, UserListState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case UserListStatus.failure:
            return const Center(
              child: Text("Error occured while fetching user list."),
            );
          case UserListStatus.success:
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NameCard(
                    avartar: state.userList[index].avatar,
                    name: state.userList[index].name,
                    createdAt: state.userList[index].createdAt,
                  );
                },
                itemCount: state.userList.length,
              ),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
