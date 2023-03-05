import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final FocusNode searchFocusNode;
  final Function(String value) onChange;
  const SearchBar(
      {Key? key, required this.onChange, required this.searchFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color surface = Theme.of(context).colorScheme.surface;
    Color secondary = Theme.of(context).colorScheme.secondary;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
            border: Border.all(
              color: surface,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xFF131313)),
        child: _buildTextField(surface: surface, secondary: secondary));
  }

  TextField _buildTextField(
      {required Color surface, required Color secondary}) {
    return TextField(
      onChanged: onChange,
      focusNode: searchFocusNode,
      style: TextStyle(color: secondary),
      decoration: InputDecoration(
        hintText: 'Search by user id',
        hintStyle: TextStyle(fontSize: 16, color: surface),
        prefixIcon: Icon(Icons.search, color: surface),
        border: InputBorder.none,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      ),
    );
  }
}
