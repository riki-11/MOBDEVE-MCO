import 'package:flutter/material.dart';
import 'package:mobdeve_mco/models/list.dart';

class ListContainerView extends StatelessWidget {
  final ListModel list;
  const ListContainerView({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(10),
          height: 170.0, // TODO: what to do about this?
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    list.title,
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                  Text(
                    list.description,
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                ],
              )
            )
          ],
        )
      ),
      onTap: () {}
    );
  }

}
