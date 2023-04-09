// ignore_for_file: unused_field, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/presentation/theme/app_color.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/widgets/vehicle_textfield.dart';
import 'package:provider/provider.dart';

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
        "userId": Provider.of<CurrentUser>(context, listen: false)
            .user
            .userId
            .toString(),
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: double.infinity,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add ur Vehicle',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          FloatingActionButton.extended(
                            onPressed: () => {
                              if (_formKey.currentState!.validate())
                                {registerVehicle()}
                            },
                            backgroundColor: const Color(0xFF11D195),
                            label: const Text('Add'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: MediaQuery.of(context).size.height * 1,
                width: MediaQuery.of(context).size.width * 1,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your vehicle';
                          } else if (![
                            'Bajaj',
                            'Hero',
                            'TVS',
                            'Yamaha',
                            'Honda',
                            'Suzuki',
                            'KTM',
                            'Royal Enfield',
                            'Toyota',
                            'Ford',
                            'Hyundai',
                            'Kia',
                            'Mahindra',
                            'Tata',
                            'Mitsubishi',
                            'Isuzu',
                            'SsangYong',
                            'Jeep',
                            'Land Rover',
                            'Range Rover',
                            'Audi',
                            'BMW',
                            'Mercedes-Benz',
                            'Mercedes',
                            'Volkswagen',
                            'Volvo',
                            'Mazda',
                            'Nissan',
                            'Peugeot',
                            'Renault',
                            'Skoda',
                            'Subaru',
                            'Tesla',
                            'Chevrolet',
                            'Datsun',
                            'Fiat',
                            'Jaguar',
                            'Lexus',
                            'Mini',
                            'Porsche',
                            'Rolls-Royce',
                            'Smart',
                            'Tesla',
                            'Other',
                          ]
                              .map((e) => e.toLowerCase())
                              .contains(value.toLowerCase())) {
                            return 'Invalid company';
                          }
                          return null;
                        },
                      ),
                      VehicleTextField(
                        labelText: 'Model Name',
                        helperText: 'Example. SX67HDD321',
                        maxLength: 10,
                        controller: modelController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your vehicle vehicle model';
                          }
                          return null;
                        },
                      ),
                      VehicleTextField(
                        labelText: 'Year',
                        helperText: 'Example. 2022',
                        maxLength: 4,
                        controller: yearController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the year of your vehicle';
                          }
                          // Check if the year is a valid integer
                          int year;
                          try {
                            year = int.parse(value);
                          } catch (e) {
                            return 'Please enter a valid year';
                          }
                          // Check if the year is within the past 20 years
                          int currentYear = DateTime.now().year;
                          if (year < currentYear - 20 || year > currentYear) {
                            return 'Invalid year. Please enter a year within the past 20 years';
                          }
                          return null;
                        },
                      ),
                      VehicleTextField(
                        labelText: 'Color',
                        helperText: 'Example. Red, White, Grey',
                        maxLength: 10,
                        controller: colorController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the color of your car';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 2,
                        color: AppColor.black,
                      ),
                      const SizedBox(
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
                        labelText: 'License Plate Number',
                        helperText: 'Example. 34 PAA 0333',
                        maxLength: 20,
                        controller: licenseNumberController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your vehicle license plate';
                          }
                          // Check if the license plate matches the format of Nepal's license plates
                          RegExp regex = new RegExp(
                              r"^[A-Z]{2}\s[0-9]{2}\s[A-Z]{1,3}\s[0-9]{1,4}$");
                          if (!regex.hasMatch(value)) {
                            return 'Invalid license plate format. \nThe format should be XX 00 X 0000, \nwhere X is a letter and 0 is a digit.';
                          }
                          return null;
                        },
                      ),
                      VehicleTextField(
                        labelText: 'State Of Registration',
                        helperText: 'Example. Bagmati, Narayani',
                        maxLength: 10,
                        controller: stateController,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a number';
                          }
                          int? number = int.tryParse(value);
                          if (number == null || number < 1 || number > 7) {
                            return 'Please enter a number between 1 and 7';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
