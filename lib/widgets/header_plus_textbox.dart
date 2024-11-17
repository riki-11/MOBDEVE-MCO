import "package:flutter/material.dart";

class HeaderPlusTextbox extends StatelessWidget {
  final String header;
  // The quill
  // The textediting controller
  const HeaderPlusTextbox({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(header,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.left,
          ),
        ),


      ],
    );
  }
}
