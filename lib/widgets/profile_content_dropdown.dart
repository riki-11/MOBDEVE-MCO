import 'package:flutter/material.dart';

class ProfileContentDropdown extends StatefulWidget {
  final List<String> options;

  const ProfileContentDropdown({
    super.key,
    required this.options
  });

  @override
  State<ProfileContentDropdown> createState() => _ProfileContentDropdownState();
}

class _ProfileContentDropdownState extends State<ProfileContentDropdown> {
  late List<String> options;
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.options[0];
    options = widget.options;
  }

  // TODO: find way to remove or edit border around dropdownmenu.
  @override Widget build (BuildContext context) {
    return DropdownMenu<String>(
      width: double.infinity,
      initialSelection: selectedOption,
      textStyle: Theme.of(context).textTheme.titleMedium,
      enableSearch: false,
      dropdownMenuEntries: options.map((String content) {
        return DropdownMenuEntry<String>(
          value: content,
          label: content,
          style: ButtonStyle(
            textStyle: WidgetStateProperty.all(Theme.of(context).textTheme.titleSmall)
          )
        );
      }).toList(),
      onSelected: (String? newOption) {
        setState(() {
          selectedOption = newOption;
        });
      }
    );
  }
}