import 'package:flutter/material.dart';

import '../../../../../core/presentation/theme/app_color.dart';

class KYCTextField extends StatelessWidget {
  const KYCTextField(
      {super.key,
      required this.labelText,
      this.helperText,
      this.maxLength,
      this.controller});
  final String labelText;
  final String? helperText;
  final int? maxLength;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill up all details';
            }
            return null;
          },
          cursorColor: AppColor.primary,
          // initialValue: '',
          maxLength: maxLength,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: AppColor.grey,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            helperText: helperText,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primary,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
