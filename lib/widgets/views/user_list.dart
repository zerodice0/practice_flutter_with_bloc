import 'package:flutter/material.dart';
import 'package:flutter_component_structure_practice/components/data_list_view.dart';
import 'package:flutter_component_structure_practice/components/namecard.dart';
import 'package:flutter_component_structure_practice/widgets/bloc/user_list_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_component_structure_practice/widgets/models/user.dart';

class UserList extends StatefulWidget {
  final VoidCallback refresh;

  const UserList({
    Key key,
    this.refresh,
  }) : super(key: key);

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

  Future<void> _showDialog(User user) async => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            "Name Card",
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 300,
              height: 80,
              child: NameCard(
                name: user.name,
                avartar: user.avatar,
                createdAt: user.createdAt,
              ),
            ),
          ),
          actions: [
            RaisedButton(
              child: Text("Hello, ${user.name}"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      );

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
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      shape: CircleBorder(),
                      child: Icon(Icons.refresh),
                      onPressed: () => _userListBloc.add(
                        UserListFetched(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
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
                      onTap: (index) {
                        _showDialog(state.userList[index]);
                      },
                    ),
                  )
                ],
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
