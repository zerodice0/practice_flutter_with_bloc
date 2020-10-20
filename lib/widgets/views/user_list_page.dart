import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_component_structure_practice/widgets/bloc/user_list_bloc.dart';
import 'package:flutter_component_structure_practice/widgets/views/user_list.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UserListBloc(httpClient: http.Client())
        ..add(
          UserListFetched(),
        ),
      child: UserList(),
    );
  }
}
