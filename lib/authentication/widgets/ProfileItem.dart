import 'package:flutter/material.dart';
import 'package:template/features/authentication/models/user.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/extentions/padding_extentions.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String? value;
  const ProfileItem(this.title, this.value, {Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(value == null){
      return AppSize.h1.ph;
    }else{
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            Expanded(
              child: Text(
                value ?? 'Not available',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
