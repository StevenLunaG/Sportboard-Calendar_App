import 'package:flutter/material.dart';

class SearcherScreen extends StatefulWidget {
  @override
  _SearcherScreenState createState() => _SearcherScreenState();
}

class _SearcherScreenState extends State<SearcherScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];

  void _onSearchChanged() {
    // Aquí puedes agregar la lógica para filtrar los resultados de búsqueda
    setState(() {
      _searchResults = _getSearchResults(_searchController.text);
    });
  }

  List<String> _getSearchResults(String query) {
    // Simulación de resultados de búsqueda
    List<String> allResults = ['Result 1', 'Result 2', 'Result 3'];
    return allResults
        .where((result) => result.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar...',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
            ),
            onChanged: (value) => _onSearchChanged(),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_searchResults[index]),
          );
        },
      ),
    );
  }
}