import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/admin/organizers/ListOragnizers.dart';
import 'package:template/features/vistor/bathrooms/bathroomsMenOrWomen_page.dart';
import 'package:template/features/vistor/bathrooms/bathrooms_page.dart';
import 'package:template/features/vistor/gates/gates_page.dart';
import 'package:template/features/vistor/home/vistor_home_viewmodel.dart';
import 'package:template/features/vistor/home/widgets/add_missings_page.dart';
import 'package:template/features/vistor/home/widgets/add_report_for_missing_person.dart';
import 'package:template/features/vistor/reports/reports_page.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';

class VistorHomePage extends StatefulWidget {
  const VistorHomePage({Key? key}) : super(key: key);

  @override
  State<VistorHomePage> createState() => _VistorHomePageState();
}

class _VistorHomePageState extends State<VistorHomePage> {
  VistorHomeViewModel vistorHomeViewModel = VistorHomeViewModel();
  bool isPersons = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhiteColor,
      ),
      backgroundColor: AppColors.kWhiteColor,
      body: Container(
        padding: EdgeInsets.all(20.sp),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => GatesPage()));
                },
                child: SizedBox(
                  height: 150.sp,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Container(
                        height: 100.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.kMainColor
                        ),
                      ),
                      Positioned(
                        bottom: 10.sp,
                        right: 15.sp,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(Resources.gate1, height: 150.sp,),
                            AppSize.h10.pw,
                            Container(
                                height: 100.sp,
                                alignment: Alignment.bottomCenter,
                                child: Text("الاستعلام عن البوابات", style: AppStyles.kTextStyle20,)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              AppSize.h20.ph,

              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BathRoomsMenOrWomenPage()));
                },
                child: Container(
                  height: 100.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.kMainColor
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppSize.h10.pw,
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.kWhiteColor
                          ),
                          padding: EdgeInsets.all(10),
                          child: Image.asset(Resources.toilet, height: 60.sp,)),
                      AppSize.h10.pw,
                      Text("الاستعلام عن دورات المياه", style: AppStyles.kTextStyle20,),
                    ],
                  ),
                ),
              ),
          
              AppSize.h20.ph,

              PrefManager.currentUser?.type == 1?
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMissingsPage(viewModel: vistorHomeViewModel,)));
                      },
                      child: Container(
                        height: 100.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.kMainColor
                        ),
                        padding: EdgeInsets.all(10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("الإبلاغ عن مفقودات", style: AppStyles.kTextStyle14,),
                            AppSize.h5.ph,
                            Image.asset(Resources.walletdynamiccolor, height: 40.sp,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AppSize.h10.pw,
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReportForMissingPerson(viewModel: vistorHomeViewModel,)));
                      },
                      child: Container(
                        height: 100.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.kMainColor
                        ),
                        padding: EdgeInsets.all(10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("الإبلاغ عن شخص مفقود", style: AppStyles.kTextStyle14,),
                            AppSize.h5.ph,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Resources.girldynamiccolor, height: 40.sp,),
                                Image.asset(Resources.girldynamiccolor, height: 40.sp,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ):
              PrefManager.currentUser?.type == 2?
              InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportsPage(isAll: true,)));
                },
                child: Container(
                  height: 100.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.kMainColor
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppSize.h10.pw,
                      Row(
                        children: [
                          Image.asset(Resources.walletdynamiccolor, height: 60.sp,),
                          Image.asset(Resources.girldynamiccolor, height: 60.sp,),
                        ],
                      ),
                      AppSize.h10.pw,
                      Text("البلاغات", style: AppStyles.kTextStyle20,),
                    ],
                  ),
                ),
              ):
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportsPage(isAll: true,)));
                      },
                      child: Container(
                        height: 100.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.kMainColor
                        ),
                        padding: EdgeInsets.all(10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("البلاغات", style: AppStyles.kTextStyle14,),
                            AppSize.h5.ph,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Resources.walletdynamiccolor, height: 40.sp,),
                                Image.asset(Resources.girldynamiccolor, height: 40.sp,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AppSize.h10.pw,
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListOragnizers()));
                      },
                      child: Container(
                        height: 100.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.kMainColor
                        ),
                        padding: EdgeInsets.all(10.sp),
                        alignment: Alignment.center,
                        child: Text("المنظمين", style: AppStyles.kTextStyleHeader18,),
                      ),
                    ),
                  ),
                ],
              ),
          
          
              AppSize.h20.ph,
              Card(
                color: AppColors.kWhiteColor,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("الإعلانات", style: AppStyles.kTextStyle20.copyWith(
                        color: AppColors.kMainColor
                      ),),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 100.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.kbackLoginColor
                              ),
                              padding: EdgeInsets.all(10.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text("طفل مفقود بعمر سنتين", style: AppStyles.kTextStyle12.copyWith(
                                      color: AppColors.kWhiteColor
                                    ),),
                                  ),
                                  AppSize.h5.pw,
                                  Icon(Icons.arrow_forward_ios, size: 25.sp, color: AppColors.kWhiteColor,)
                                ],
                              ),
                            ),
                          ),
                          AppSize.h10.pw,
                          Expanded(
                            child: Container(
                              height: 100.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.kbackLoginColor
                              ),
                              padding: EdgeInsets.all(10.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text("مسنّة باكستانية", style: AppStyles.kTextStyle12.copyWith(
                                      color: AppColors.kWhiteColor
                                    ),),
                                  ),
                                  AppSize.h5.pw,
                                  Icon(Icons.arrow_forward_ios, size: 25.sp, color: AppColors.kWhiteColor,)
                                ],
                              ),
                            ),
                          ),
                          AppSize.h10.pw,
                          Expanded(
                            child: Container(
                              height: 100.sp,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.kbackLoginColor
                              ),
                              padding: EdgeInsets.all(10.sp),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text("طفلة مفقودة بعمر ٥ سنوات", style: AppStyles.kTextStyle12.copyWith(
                                      color: AppColors.kWhiteColor
                                    ),),
                                  ),
                                  AppSize.h5.pw,
                                  Icon(Icons.arrow_forward_ios, size: 25.sp, color: AppColors.kWhiteColor,)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          
          
            ],
          ),
        ),
      ),
    );
  }
}
