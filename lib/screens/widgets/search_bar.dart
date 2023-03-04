import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color surface = Theme.of(context).colorScheme.surface;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
          border: Border.all(
            color: surface,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xFF131313)),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search by user id',
          hintStyle: TextStyle(fontSize: 16, color: surface),
          prefixIcon: Icon(Icons.search, color: surface),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }
}
