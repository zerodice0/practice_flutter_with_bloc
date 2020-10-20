import 'package:flutter/material.dart';

typedef Int2VoidFunc = void Function(int);

class DataListView extends StatelessWidget {
  final List<Widget> datas;
  final Int2VoidFunc onTap;
  final Int2VoidFunc onLongPress;

  const DataListView({
    Key key,
    this.datas,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: datas.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: datas[index],
          onTap: () {
            this.onTap?.call(index);
          },
          onLongPress: () {
            this.onLongPress?.call(index);
          },
        );
      },
    );
  }
}
