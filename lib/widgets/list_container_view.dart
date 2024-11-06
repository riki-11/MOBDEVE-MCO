import 'package:flutter/material.dart';

class ListContainerView extends StatelessWidget {
  const ListContainerView({super.key});

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
                    "Freshman Year",
                    style: Theme.of(context).textTheme.titleLarge
                  ),
                  Text(
                    "List by riki11",
                    style: Theme.of(context).textTheme.bodyMedium
                  ),
                  Text(
                    "A list with guides for all my 1st year subjects in ComSci at DLSU.",
                    style: Theme.of(context).textTheme.bodyLarge
                  ),
                  Text(
                    "7 articles from Enrique Lejano, Cornars, Joshbb, and more. ",
                    style: Theme.of(context).textTheme.bodyMedium
                  )
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