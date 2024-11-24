import 'package:flutter/material.dart';

class ProfileContentDropdown extends StatefulWidget {
  final List<String> options;
  final void Function(String?) onChanged;

  const ProfileContentDropdown({
    super.key,
    required this.options,
    required this.onChanged
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
        widget.onChanged(newOption);
      }
    );
  }
}