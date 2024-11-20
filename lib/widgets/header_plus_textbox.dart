import "package:flutter/material.dart";
import "package:flutter_quill/flutter_quill.dart";

class HeaderPlusTextbox extends StatelessWidget {
  final String header;
  final QuillController? controller;
  const HeaderPlusTextbox({super.key,
    required this.header,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

  // final FocusNode _focusNode = FocusNode();
  // final ScrollController _scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(header.toUpperCase(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold
          ),
          textAlign: TextAlign.left,
        ),

        // TODO: Toolbar above keyboard
        QuillEditor.basic(
          // focusNode: _focusNode,
          // scrollController: _scrollController,
          controller: controller,
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
