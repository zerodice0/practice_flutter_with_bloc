import 'package:flutter/material.dart';
import 'package:flutter_component_structure_practice/components/data_list_view.dart';
import 'package:flutter_component_structure_practice/components/namecard.dart';
import 'package:flutter_component_structure_practice/widgets/bloc/user_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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
              child: DataListView(
                datas: state.userList
                    .map(
                      (e) => NameCard(
                        avartar: e.avatar,
                        name: e.name,
                        createdAt: e.createdAt,
                      ),
                    )
                    .toList(),
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
