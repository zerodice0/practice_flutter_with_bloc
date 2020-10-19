import 'package:flutter/material.dart';

class NameCard extends StatelessWidget {
  final String name;
  final String createdAt;
  final String avartar;

  const NameCard({
    Key key,
    this.name,
    this.createdAt,
    this.avartar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: Image.network(avartar),
            title: Text(name),
            subtitle: Text(createdAt),
          ),
        ],
      ),
    );
  }
}
