import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, this.searchController});
  final TextEditingController? searchController;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 55,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFE1F2ED),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          hintText: 'Search Your Destination',
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: AppColor.black,
          ),
          suffixIcon: Icon(
            Icons.mic,
            color: AppColor.searchIcon,
          ),
        ),
      ),
    );
  }
}
