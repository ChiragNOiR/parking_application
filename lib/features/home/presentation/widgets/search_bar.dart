// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({Key? key, this.searchController, this.onSubmitted})
      : super(key: key);
  final TextEditingController? searchController;
  final onSubmitted;

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

enum TtsState { playing, stopped }

class _HomeSearchBarState extends State<HomeSearchBar> {
  @override
  Widget build(BuildContext context) {
    final FocusNode searchFocusNode = FocusNode();
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        // show keyboard
        FocusScope.of(context).requestFocus(searchFocusNode);
      } else {
        // hide keyboard
        FocusScope.of(context).unfocus();
      }
    });

    return Container(
      width: 320,
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F2ED),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        onSubmitted: widget.onSubmitted,
        focusNode: searchFocusNode,
        controller: widget.searchController,
        onChanged: (text) {},
        decoration: const InputDecoration(
          hintText: 'Search Your Destination',
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: AppColor.black,
          ),
        ),
      ),
    );
  }
}
