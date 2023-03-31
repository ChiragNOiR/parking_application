import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_app/core/shared/config.dart';
import 'package:parking_app/features/profile/application/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final cloudinary = CloudinaryPublic('dhqrq8v9p', 'txwmcoag');

      final result = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(imageFile.path,
            folder:
                Provider.of<CurrentUser>(context, listen: false).user.fullName),
      );
      final regBody = {
        'profile': result.secureUrl,
        'email':
            Provider.of<CurrentUser>(context, listen: false).user.userEmail,
      };
      try {
        final response = await http.post(
          Uri.parse(uploadProfile),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(regBody),
        );

        final jsonResponse = jsonDecode(response.body);
      } catch (e) {
        print('dd');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
      child: Container(
        height: 120,
        width: 102,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50,
              // backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                Provider.of<CurrentUser>(context, listen: false)
                    .user
                    .userProfile!,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                onPressed: () async {
                  await _pickImage(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.add_a_photo,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
