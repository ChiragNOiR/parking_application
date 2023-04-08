// ignore_for_file: prefer_final_fields, unused_field, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/profile/presentation/kyc/widgets/kyc_textfield.dart';
import 'package:provider/provider.dart';

import '../../application/user_provider.dart';
import 'package:http/http.dart' as http;

class AddKYC extends StatefulWidget {
  const AddKYC({super.key});

  @override
  State<AddKYC> createState() => _AddKYCState();
}

class _AddKYCState extends State<AddKYC> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController dobController = TextEditingController();
  TextEditingController citizenshipNumberController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController doiController = TextEditingController();
  TextEditingController doeController = TextEditingController();
  TextEditingController licenseNumberController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String? selectedOffice;
  bool _isNotValidate = false;

  void registerKyc() async {
    if (citizenshipNumberController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        doiController.text.isNotEmpty &&
        doeController.text.isNotEmpty &&
        dobController.text.isNotEmpty &&
        licenseNumberController.text.isNotEmpty) {
      var regBody = {
        "userId": Provider.of<CurrentUser>(context, listen: false)
            .user
            .userId
            .toString(),
        "fullName": Provider.of<CurrentUser>(context, listen: false)
            .user
            .fullName
            .toString(),
        "address": Provider.of<CurrentUser>(context, listen: false)
            .user
            .userAddress
            .toString(),
        "dateOfBirth": dobController.text,
        "licenseOffice": selectedOffice,
        "licenseNumber": licenseNumberController.text,
        "citizenshipNumber": citizenshipNumberController.text,
        "category": categoryController.text,
        "contact": Provider.of<CurrentUser>(context, listen: false)
            .user
            .userContact
            .toString(),
        "dateOfIssue": doiController.text,
        "dateOfExpiry": doeController.text,
        "status": "pending",
        "profile": Provider.of<CurrentUser>(context, listen: false)
            .user
            .userProfile
            .toString(),
      };
      var response = await http.post(
        Uri.parse(createKYC),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body);

      print(jsonResponse['success']);

      if (jsonResponse['status']) {
        Navigator.pop(context);
      } else {
        print('error');
      }
    } else {
      print('hh');
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              const SizedBox(
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
                              child: const Icon(Icons.arrow_back),
                              onTap: () => Navigator.pop(context),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'KYC Verification',
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
                                onPressed: () => {
                                  if (_formKey.currentState!.validate())
                                    {registerKyc()}
                                },
                                backgroundColor: const Color(0xFF11D195),
                                label: const Text('Update'),
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
                child: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      color: Colors.white,
                    ),
                    width: 395,
                    height: 800,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          KYCTextField(
                            labelText: 'Date Of Birth',
                            onTap: () async {
                              DateTime? picked = await _selectDate(context);
                              if (picked != null) {
                                dobController.text = picked.toString();
                              }
                            },
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Date of birth is required';
                              }
                              DateTime? dob = DateTime.tryParse(value);
                              if (dob == null) {
                                return 'Invalid date format';
                              }
                              if (dob.isAfter(DateTime.now())) {
                                return 'Date of birth must be in the past';
                              }
                              return null;
                            },
                            controller: dobController,
                            focusNode: _focusNode,
                            textInputAction: TextInputAction.none,
                          ),
                          KYCTextField(
                            labelText: 'License Category',
                            helperText: 'A, B, H1, K',
                            maxLength: 2,
                            controller: categoryController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your category';
                              } else if (![
                                'A',
                                'B',
                                'C',
                                'C1',
                                'D',
                                'E',
                                'F',
                                'G',
                                'H',
                                'H1',
                                'H2',
                                'I',
                                'I1',
                                'I2',
                                'I3',
                                'J1',
                                'J2',
                                'J3',
                                'J4',
                                'J5',
                                'K',
                              ].contains(value.toUpperCase())) {
                                return 'Invalid category';
                              }
                              return null;
                            },
                          ),
                          KYCTextField(
                            labelText: 'License Number',
                            controller: licenseNumberController,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your License Number';
                              }
                              if (!RegExp(r'^[\d-]+$').hasMatch(value)) {
                                return 'License number can only contain numerical characters';
                              }
                              return null; // return null if there are no errors
                            },
                          ),
                          KYCTextField(
                            labelText: 'Citizenship Number',
                            controller: citizenshipNumberController,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Citizenship Number';
                              }
                              if (!RegExp(r'^[\d-]+$').hasMatch(value)) {
                                return 'Citizenship Number can only contain numerical characters';
                              }
                              return null; // return null if there are no errors
                            },
                          ),
                          KYCTextField(
                            labelText: 'Date of Issue',
                            controller: doiController,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Date of issue is required';
                              }
                              DateTime? dob = DateTime.tryParse(value);
                              if (dob == null) {
                                return 'Invalid date format';
                              }
                              if (dob.isAfter(DateTime.now())) {
                                return 'Date of issue must be in the past';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? picked = await _selectDate(context);
                              if (picked != null) {
                                doiController.text = picked.toString();
                              }
                            },
                            focusNode: _focusNode,
                            textInputAction: TextInputAction.none,
                          ),
                          KYCTextField(
                            labelText: 'Date of Expiry',
                            controller: doeController,
                            validate: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Date of expiry is required';
                              }
                              DateTime? dob = DateTime.tryParse(value);
                              if (dob == null) {
                                return 'Invalid date format';
                              }
                              if (dob.isBefore(DateTime.now())) {
                                return 'Date of expiry must be in the future';
                              }
                              return null;
                            },
                            onTap: () async {
                              DateTime? picked = await _selectDate(context);
                              if (picked != null) {
                                doeController.text = picked.toString();
                              }
                            },
                            focusNode: _focusNode,
                            textInputAction: TextInputAction.none,
                          ),
                          DropdownButtonFormField(
                            decoration: const InputDecoration(
                              labelText: 'License Office',
                            ),
                            value:
                                selectedOffice, // This should be a variable that holds the selected option
                            onChanged: (newValue) {
                              setState(() {
                                selectedOffice = newValue;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'ekantakuna',
                                child: Text('Ekantakuna'),
                              ),
                              DropdownMenuItem(
                                value: 'chabhail',
                                child: Text('Chabhail'),
                              ),
                              DropdownMenuItem(
                                value: 'radheRadhe',
                                child: Text('Radhe Radhe'),
                              ),
                              DropdownMenuItem(
                                value: 'thuloBhyrang',
                                child: Text('Thulo Bhyrang'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(currentDate.year + 10),
    );
    return picked;
  }
}
