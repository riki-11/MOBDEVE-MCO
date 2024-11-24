import "package:flutter/material.dart";
import "package:flutter_quill/flutter_quill.dart";

class HeaderPlusTextbox extends StatelessWidget {
  final String header;
  final QuillController? controller;
  final FocusNode focusNode;
  const HeaderPlusTextbox({super.key,
    required this.header,
    required this.controller,
    required this.focusNode
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.left,
        ),

        QuillEditor.basic(
          controller: controller,
          focusNode: focusNode,
          configurations: const QuillEditorConfigurations(
              placeholder: 'Start typing here...',
              padding: EdgeInsets.only(top: 8.0)
          ),
        ),

        const Padding(padding: EdgeInsets.only(bottom: 50.0)),

      ],
    );
  }
}
