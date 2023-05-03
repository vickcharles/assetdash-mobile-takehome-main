import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final FocusNode searchFocusNode;
  final Function(String value) onChange;

  const SearchBar({
    Key? key,
    required this.onChange,
    required this.searchFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;
    final secondaryColor = theme.colorScheme.secondary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: surfaceColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xFF131313),
      ),
      child: _buildTextField(surfaceColor, secondaryColor),
    );
  }

  TextField _buildTextField(Color surfaceColor, Color secondaryColor) {
    return TextField(
      onChanged: onChange,
      focusNode: searchFocusNode,
      style: TextStyle(color: secondaryColor),
      decoration: InputDecoration(
        hintText: 'Search by user id',
        hintStyle: TextStyle(fontSize: 16, color: surfaceColor),
        prefixIcon: Icon(Icons.search, color: surfaceColor),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}
