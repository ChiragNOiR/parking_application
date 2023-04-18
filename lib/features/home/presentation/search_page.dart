// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:parking_app/core/presentation/theme/app_color.dart';

import '../../../core/shared/config.dart';
import '../../explore/domain/location_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  late List<LocationModel> list = [];
  Future<List<LocationModel>> getTemple() async {
    try {
      final response = await http.get(Uri.parse(getTempleList));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => LocationModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Temple Data');
      }
    } catch (e) {
      throw Exception('Failed to load Temple Data: $e');
    }
  }

//method to get search data
  void _search(String query) async {
    if (query.isNotEmpty) {
      // Check if the query is not empty
      final response = await http.get(Uri.parse('$searchLocationAPI/$query'));
      final jsonResponse = json.decode(response.body);

      setState(() {
        _searchResults = jsonResponse['success'];
      });
    } else {
      setState(() {
        _searchResults =
            []; // Set search results to empty list if query is empty
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.black,
          ),
        ),
        title: SizedBox(
          height: 60,
          child: TextField(
            controller: _searchController,
            onSubmitted: _search,
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
              ),
            ),
          ),
        ),
      ),
      body: _searchResults.isEmpty && _searchController.text.isEmpty
          ? const Center(child: Text('Search your desired location to park.'))
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: ListTile(
                    title: Text(_searchResults[index]['title']),
                    subtitle: Text(_searchResults[index]['description']),
                  ),
                );
              },
            ),
    );
  }
}
