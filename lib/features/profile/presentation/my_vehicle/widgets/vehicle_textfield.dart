import 'package:flutter/material.dart';

import '../../../../../core/presentation/theme/app_color.dart';

class VehicleTextField extends StatelessWidget {
  const VehicleTextField(
      {super.key, required this.labelText, this.helperText, this.maxLength});
  final String labelText;
  final String? helperText;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          cursorColor: AppColor.primary,
          initialValue: '',
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
