import 'package:flutter/material.dart';

import '../../../../../core/presentation/theme/app_color.dart';

class VehicleTextField extends StatelessWidget {
  const VehicleTextField(
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
            labelStyle: const TextStyle(
              color: AppColor.grey,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            helperText: helperText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.primary,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
