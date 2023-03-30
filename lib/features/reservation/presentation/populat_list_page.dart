import 'package:flutter/material.dart';
import 'package:parking_app/features/explore/domain/location_model.dart';

class PopularListPage extends StatefulWidget {
  const PopularListPage({super.key, required this.location});
  final LocationModel location;

  @override
  State<PopularListPage> createState() => _PopularListPageState();
}

class _PopularListPageState extends State<PopularListPage> {
  late LocationModel _loc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loc = widget.location;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(_loc.title)),
    );
  }
}
