import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';


class VistorProfileWidget extends StatelessWidget {
  const VistorProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.kWhiteColor, elevation: 0,),
      backgroundColor: AppColors.kWhiteColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kBlackColor),
                shape: BoxShape.circle
              ),
              padding: EdgeInsets.all(20.sp),
              child: Image.asset(Resources.user, height: 70.sp, color: AppColors.kBlackColor,),
            ),
            AppSize.h10.ph,
            Text("الحساب الشخصي", style: AppStyles.kTextStyle16,),
            AppSize.h10.ph,
            Divider(),
            AppSize.h20.ph,
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: AppColors.kbackProfileDataColor
                ),
                padding: EdgeInsets.symmetric(vertical: 40.sp, horizontal: 10.sp),
                width: MediaQuery.of(context).size.width- 30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap:(){},
                        child: Image.asset(Resources.edit_vistor, height: 25.sp,)
                    ),
                    AppSize.h40.ph,
                    Text("الاسم | ${PrefManager.currentUser?.name ?? ""}", style: AppStyles.kTextStyle18,),
                    AppSize.h20.ph,
                    Text("رقم الجوال | ${PrefManager.currentUser?.phone ?? ""}", style: AppStyles.kTextStyle18,),
                  ],
                )),
            Spacer(),
            CustomButton(title: "تسجيل الخروج",
                width: 100.sp,
                radius: 20,
                textSize: 14.sp,
                btnColor: AppColors.kbackLoginColor,
                onClick: (){
              PrefManager.clearUserData();
              UI.pushWithRemove(AppRoutes.toggleBetweenUsers);
            }),
            AppSize.h100.ph,
          ],
        ),
      ),
    );
  }
}