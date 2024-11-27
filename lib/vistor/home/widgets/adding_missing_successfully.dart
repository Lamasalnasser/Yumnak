import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/vistor/home/models/MissingModel.dart';
import 'package:template/features/vistor/reports/widgets/report_details.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';

class AddingMissingSuccessfully extends StatelessWidget {
  final MissingModel missingModel;
  const AddingMissingSuccessfully({Key? key, required this.missingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: AppColors.kWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.kWhiteColor,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height- 100,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppSize.h40.ph,
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.kbackLoginColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                      )
                  ),
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.all(20.sp),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.kbackLoginColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.all(10.sp),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text("تم رفع البلاغ!", style: AppStyles.kTextStyleHeader36.copyWith(
                            color: AppColors.kWhiteColor
                          ),),
                          AppSize.h40.ph,
                          Image.asset(Resources.successful, height: 250.sp,),
                          AppSize.h40.ph,

                          CustomButton(
                              title: "عرض تفاصيل البلاغ",
                              textSize: 12.sp,
                              radius: 20,
                              onClick: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ReportDetailsPage(missingModel: missingModel,)));
                              }),
                          AppSize.h20.ph,
                          CustomButton(
                              title: "الانتقال للصفحة الرئيسية",
                              textSize: 12.sp,
                              radius: 20,
                              onClick: (){
                                UI.pushWithRemove(AppRoutes.vistorstartPage);
                              })
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
