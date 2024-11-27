import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:template/features/authentication/login/customer_login_page.dart';
import 'package:template/features/vistor/home/models/MissingModel.dart';
import 'package:template/features/vistor/home/vistor_home_viewmodel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/util/helper.dart';

class ReportDetailsPage extends StatelessWidget {
  final MissingModel missingModel;
  ReportDetailsPage({Key? key, required this.missingModel}) : super(key: key);

  VistorHomeViewModel viewModel = VistorHomeViewModel();

  @override
  Widget build(BuildContext context) {

    // Decode Base64 String to Uint8List
    Uint8List imageBytes = base64Decode(missingModel.image ?? "");

    // Date and time to be formatted
    DateTime dateTime = missingModel.createTime ??  DateTime(2024, 11, 3, 10, 0); // Example: 3 November 2024, 10:00 AM

    // Format for English date
    String formattedDateEn = DateFormat('d MMMM, y').format(dateTime);

    // Format for Arabic time (adjusted for Arabic numerals and AM/PM in Arabic)
    String formattedTimeAr = DateFormat('h:mm a', 'ar').format(dateTime)
        .replaceAll('AM', 'صباحًا') // Replace English AM with Arabic
        .replaceAll('PM', 'مساءً'); // Replace English PM with Arabic

    // Combine formatted date and time
    String finalFormattedDate = '$formattedDateEn | $formattedTimeAr';

    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("تفاصيل البلاغ", style: AppStyles.kTextStyleHeader20,),
            AppSize.h10.ph,
            Container(
              decoration: BoxDecoration(
                color: AppColors.kbackLoginColor,
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.all(20.sp),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.kWhiteColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 15.sp,
                          width: 15.sp,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.kbackLoginColor
                          ),
                        ),
                        AppSize.h10.pw,
                        Expanded(child: Text(missingModel.fullName ?? "", maxLines: 1, style: AppStyles.kTextStyle20,)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(Resources.clock, height: 25.sp,),
                        AppSize.h10.pw,
                        Text(finalFormattedDate, style: AppStyles.kTextStyle14,),
                      ],
                    ),
                    AppSize.h10.ph,
                    Text("بلاغ رقم ${missingModel.id}", style: AppStyles.kTextStyle18,),
                    AppSize.h10.ph,
                    CustomField(
                      controller: TextEditingController(),
                      hint: missingModel.description,
                      hintStyle: AppStyles.kTextStyle14,
                      fillColor: AppColors.kWhiteColor,
                      readOnly: true,
                      maxLines: 4,
                    ),

                    AppSize.h20.ph,
                    
                    Row(
                      children: [
                        Image.asset(Resources.attachment, height: 25.sp,),
                        AppSize.h10.pw,
                        Text("الملفات المرفقة", style: AppStyles.kTextStyle14,),
                      ],
                    ),
                    Container(
                      height: 80.sp,
                      width: 200.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: MemoryImage(imageBytes),
                          fit: BoxFit.cover
                        )
                      ),
                    ),

                    AppSize.h20.ph,
                    Row(
                      children: [
                        Text("معلومات التواصل", style: AppStyles.kTextStyle14,),
                      ],
                    ),
                    CustomField(
                      controller: TextEditingController(),
                      hint: "رقم الجوال: ${missingModel.contactNumber}",
                      hintStyle: AppStyles.kTextStyle14,
                      fillColor: AppColors.kWhiteColor,
                      readOnly: true,
                      maxLines: 4,
                    ),
                    AppSize.h20.ph,
                    
                    CustomButton(
                        title: "إلغاء البلاغ",
                        width: 120.sp,
                        textSize: 12.sp,
                        radius: 20,
                        onClick: (){
                          viewModel.deleteMissing(missingModel.id ?? "");
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
