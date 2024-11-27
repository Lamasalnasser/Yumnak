import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/vistor/reports/reports_page.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';

class VistorSettingsWidget extends StatelessWidget {
  const VistorSettingsWidget({Key? key}) : super(key: key);

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
            AppSize.h10.ph,
            Text("الإعدادات", style: AppStyles.kTextStyle16,),
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
                    // InkWell(
                    //   onTap: (){},
                    //   child: Row(
                    //     children: [
                    //       Image.asset(Resources.language, height: 25.sp,),
                    //       AppSize.h10.pw,
                    //       Text("اللغة | العربية", style: AppStyles.kTextStyle18,)
                    //     ],
                    //   ),
                    // ),
                    AppSize.h20.ph,
                    InkWell(
                      onTap: (){
                        PrefManager.clearUserData();
                        UI.pushWithRemove(AppRoutes.toggleBetweenUsers);
                      },
                      child: Row(
                        children: [
                          Image.asset(Resources.XCircle, height: 25.sp,),
                          AppSize.h10.pw,
                          Text("حذف الحساب", style: AppStyles.kTextStyle18,)
                        ],
                      ),
                    ),
                    AppSize.h20.ph,
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportsPage(isAll: false,)));
                      },
                      child: Row(
                        children: [
                          Image.asset(Resources.megaphoneSimple, height: 25.sp,),
                          AppSize.h10.pw,
                          Text("بلاغاتي", style: AppStyles.kTextStyle18,)
                        ],
                      ),
                    ),
                    AppSize.h100.ph,
                  ],
                )),
            AppSize.h20.ph,

          ],
        ),
      ),
    );
  }
}