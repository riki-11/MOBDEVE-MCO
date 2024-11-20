import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String collegeName;
  final String collegeAcronym;
  final String programName;
  final String programAcronym;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.collegeName,
    required this.collegeAcronym,
    required this.programName,
    required this.programAcronym
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child:
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.account_circle_outlined, size: 64.0), // TODO: Replace with display picture.
          Flexible( // Allow the text content to take only the required space
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    username,
                    style: Theme.of(context).textTheme.titleLarge,
                    softWrap: true, // Enable wrapping
                    maxLines: 2, // Optionally limit to 2 lines
                  ),
                  Text(
                    "$collegeName ($collegeAcronym)",
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                  Text(
                    "$programName ($programAcronym)",
                    style: Theme.of(context).textTheme.bodySmall,
                    softWrap: true,
                  ),
                ],
              ),
            )
          )
        ]
      )
    );
  }
}