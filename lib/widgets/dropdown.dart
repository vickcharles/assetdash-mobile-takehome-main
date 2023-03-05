import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> options;
  final String? selectedOption;
  final Function(String) onChanged;

  const CustomDropdownButton({
    Key? key,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
  }) : super(key: key);

  @override
  _MyDropdownWidgetState createState() => _MyDropdownWidgetState();
}

class _MyDropdownWidgetState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      value: widget.selectedOption ?? 'All',
      dropdownColor: Theme.of(context).colorScheme.background,
      style: Theme.of(context).textTheme.labelMedium,
      items: widget.options.map((String option) {
        return DropdownMenuItem(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (newValue) {
        widget.onChanged(newValue.toString());
      },
    );
  }
}
