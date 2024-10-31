import 'package:flutter/material.dart';

class CheckboxOptions extends StatelessWidget {
  final String option;
  final bool value;
  final void Function(bool?) onChange;

  const CheckboxOptions({
    super.key,
    required this.option,
    required this.value,
    required this.onChange
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          CheckboxListTile(
              title: Text(
                option,
                style: Theme.of(context).textTheme.bodyLarge
              ),
              value: value,
              onChanged: onChange),
          Container(
            width: MediaQuery.of(context).size.width * 0.875,
            child: const Divider(),
          )
        ],
      ),
    );
  }
}
