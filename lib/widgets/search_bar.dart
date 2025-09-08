import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final Function(String) onSearch;

  const SearchWidget({super.key, required this.onSearch});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        labelText: 'Search for a city',
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            widget.onSearch(_searchController.text);
            FocusScope.of(context).unfocus(); // Dismiss keyboard
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onSubmitted: (value) {
        widget.onSearch(value);
      },
    );
  }
}
