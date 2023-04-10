import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import '../../../../core/shared/config.dart';
import '../../../profile/application/user_provider.dart';
import '../../../profile/domain/kyc_model.dart';

class MyDoc extends StatefulWidget {
  const MyDoc({super.key});

  @override
  State<MyDoc> createState() => _MyDocState();
}

class _MyDocState extends State<MyDoc> {
  late List<KYCModel> list = [];

  Future<List<KYCModel>> getKyc() async {
    try {
      final id = Provider.of<CurrentUser>(context).user.userId;
      final response = await http.get(Uri.parse('$getKycById/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonResponse['success']['userKyc'];
        return jsonList.map((json) => KYCModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load Kyc Data');
      }
    } catch (e) {
      throw Exception('Failed to load Vehicle Data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
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
                        'View Document \nDetails',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                        ),
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
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 1,
            child: FutureBuilder(
              future: getKyc(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.data == null) {
                  return SizedBox();
                } else {
                  final kycMap = snapshot.data!;
                  return ListView.builder(
                    itemCount: kycMap.length,
                    itemBuilder: (context, index) {
                      KYCModel kyc = kycMap[index];
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.network(
                                    kyc.licensePhoto!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.network(
                            kyc.licensePhoto!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
