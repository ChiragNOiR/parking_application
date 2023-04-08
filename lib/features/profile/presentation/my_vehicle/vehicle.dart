import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/my_vehicle.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/widgets/vehicle_detail_template.dart';
import 'package:http/http.dart' as http;
import '../../application/user_provider.dart';
import '../../domain/vehicle_model.dart';
import 'package:provider/provider.dart';

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
  late List<VehicleModel> list = [];
  Future<List<VehicleModel>> getVehicleDetails() async {
    try {
      final id = Provider.of<CurrentUser>(context).user.userId;
      print(id);
      final response = await http.get(Uri.parse('$getVehicleData/$id'));
      print(response);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonResponse['success']['userVehicle'];
        return jsonList.map((json) => VehicleModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Vehicle Data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load Vehicle Data: $e');
    }
  }
  // late User user;
  // late List<VehicleModel> list = [];
  // Future<List<VehicleModel>> getVechileDetails() async {
  //   try {
  //     final id = Provider.of<CurrentUser>(context).user.userId;
  //     print(id);
  //     final response =
  //         // await http.get(Uri.parse('$getVehicleData/${user.userId}'));
  //         // await http.get(Uri.parse(getVehicleData));
  //         await http.get(Uri.parse('$getVehicleData/$id'));
  //     print(response);
  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonList = jsonDecode(response.body);
  //       return jsonList.map((json) => VehicleModel.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load Vehicle Data');
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Failed to load Vehicle Data: $e');
  //   }
  // }
  // late User user;
  // late Map<String, VehicleModel> map = {};
  // Future<Map<String, VehicleModel>> getVechileDetails() async {
  //   try {
  //     final id = Provider.of<CurrentUser>(context).user.userId;
  //     final response =
  //         // await http.get(Uri.parse('$getVehicleData/${user.userId}'));
  //         await http.get(Uri.parse('$getVehicleData/$id'));

  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonList = jsonDecode(response.body);
  //       map = Map.fromIterable(jsonList,
  //           key: (json) => json['id'],
  //           value: (json) => VehicleModel.fromJson(json));
  //       return map;
  //     } else {
  //       throw Exception('Failed to load Vehicle Data');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load Vehicle Data: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<VehicleProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyVehicle(),
                                    ));
                              },
                              backgroundColor: const Color(0xFF11D195),
                              label: const Text('Add Vehicle'),
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
                child: FutureBuilder<List<VehicleModel>>(
                  future: getVehicleDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final vehicleMap = snapshot.data!;
                      return ListView.builder(
                          itemCount: vehicleMap.length,
                          itemBuilder: (context, index) {
                            VehicleModel vehicle = vehicleMap[index];
                            return SingleChildScrollView(
                              child: SizedBox(
                                  height: 370,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        VehicleDetailTemplate(
                                          title: "Company",
                                          text: vehicle.company,
                                        ),
                                        VehicleDetailTemplate(
                                          title: 'Model',
                                          text: vehicle.model,
                                        ),
                                        VehicleDetailTemplate(
                                          title: 'Year',
                                          text: vehicle.year,
                                        ),
                                        VehicleDetailTemplate(
                                          title: 'Color',
                                          text: vehicle.color,
                                        ),
                                        VehicleDetailTemplate(
                                          title: 'License Number',
                                          text: vehicle.licenseNumber,
                                        ),
                                        VehicleDetailTemplate(
                                          title: 'Registered State / Zone',
                                          text: vehicle.stateOfRegistration,
                                        ),
                                      ],
                                    ),
                                  )),
                            );
                          });
                    }
                  },
                ),
                // child: Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                //   child: SingleChildScrollView(
                //     child:
                //         // VehicleModel vehicle = snapshot.data!;
                //         Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         VehicleDetailTemplate(
                //           title: 'Company',
                //           text: '',
                //         ),
                //         VehicleDetailTemplate(
                //           title: 'Model',
                //           text: '',
                //         ),
                //         VehicleDetailTemplate(
                //           title: 'Year',
                //           text: '',
                //         ),
                //         VehicleDetailTemplate(
                //           title: 'Color',
                //           text: '',
                //         ),
                //         VehicleDetailTemplate(
                //           title: 'License Number',
                //           text: '',
                //         ),
                //         VehicleDetailTemplate(
                //           title: 'Registered State / Zone',
                //           text: '',
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
