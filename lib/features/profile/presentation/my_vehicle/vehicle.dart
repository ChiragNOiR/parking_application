import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/my_vehicle.dart';
import 'package:parking_app/features/profile/presentation/my_vehicle/widgets/vehicle_detail_template.dart';

class Vehicle extends StatefulWidget {
  const Vehicle({super.key});

  @override
  State<Vehicle> createState() => _VehicleState();
}

class _VehicleState extends State<Vehicle> {
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyVehicle(),
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VehicleDetailTemplate(
                          title: 'Company',
                          text: '',
                        ),
                        VehicleDetailTemplate(
                          title: 'Model',
                          text: '',
                        ),
                        VehicleDetailTemplate(
                          title: 'Year',
                          text: '',
                        ),
                        VehicleDetailTemplate(
                          title: 'Color',
                          text: '',
                        ),
                        VehicleDetailTemplate(
                          title: 'License Number',
                          text: '',
                        ),
                        VehicleDetailTemplate(
                          title: 'Registered State / Zone',
                          text: '',
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
    );
  }
}
