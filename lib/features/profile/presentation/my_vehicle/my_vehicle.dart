import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/widgets/vehicle_textfield.dart';

import '../../../../core/presentation/theme/text_style.dart';
import 'package:http/http.dart' as http;
import '../../../../core/shared/config.dart';

class MyVehicle extends StatefulWidget {
  const MyVehicle({super.key});

  @override
  State<MyVehicle> createState() => _MyVehicleState();
}

class _MyVehicleState extends State<MyVehicle> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController companyController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  bool _isNotValidate = false;

  @override
  void dispose() {
    companyController.dispose();
    modelController.dispose();
    yearController.dispose();
    colorController.dispose();
    licenseNumberController.dispose();
    stateController.dispose();
    super.dispose();
  }

  void registerVehicle() async {
    if (companyController.text.isNotEmpty &&
        modelController.text.isNotEmpty &&
        yearController.text.isNotEmpty &&
        colorController.text.isNotEmpty &&
        licenseNumberController.text.isNotEmpty &&
        stateController.text.isNotEmpty) {
      var regBody = {
        "company": companyController.text,
        "model": modelController.text,
        "year": yearController.text,
        "color": colorController.text,
        "licenseNumber": licenseNumberController.text,
        "stateOfRegistration": stateController.text,
      };

      var response = await http.post(
        Uri.parse(registerVehicleUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        Navigator.pop(context);
      } else {
        print('OOPS');
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              child: Container(
                width: double.infinity,
                height: 180,
                color: const Color(0xFFE8F4F9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            child: Icon(Icons.arrow_back),
                            onTap: () => Navigator.pop(context),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Vehicle Details',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: const Color(0xFF726666),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 35,
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                registerVehicle();
                              },
                              backgroundColor: const Color(0xFF11D195),
                              label: const Text('Add'),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                width: 395,
                height: 600,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fill up the details - ',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primary,
                          ),
                        ),
                        VehicleTextField(
                          labelText: 'Company',
                          helperText: 'Example. Honda/Suzuki/Audi',
                          maxLength: 10,
                          controller: companyController,
                        ),
                        VehicleTextField(
                          labelText: 'Model Name',
                          helperText: 'Example. SX67HDD321',
                          maxLength: 10,
                          controller: modelController,
                        ),
                        VehicleTextField(
                          labelText: 'Year',
                          helperText: 'Example. 2022',
                          maxLength: 4,
                          controller: yearController,
                        ),
                        VehicleTextField(
                          labelText: 'Color',
                          helperText: 'Example. Red, White, Grey',
                          maxLength: 10,
                          controller: colorController,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 2,
                          color: AppColor.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Primary Details -',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primary,
                          ),
                        ),
                        VehicleTextField(
                          labelText: 'License Number',
                          helperText: 'Example. 34 PAA 0333',
                          maxLength: 20,
                          controller: licenseNumberController,
                        ),
                        VehicleTextField(
                          labelText: 'State Of Registration',
                          helperText: 'Example. Bagmati, Narayani',
                          maxLength: 10,
                          controller: stateController,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
