import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/authentication/models/user.dart';
import 'package:template/features/authentication/user_viewModel.dart';
import 'package:template/features/authentication/widgets/change_password_page.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';

class AdminProfileWidget extends StatefulWidget {
  const AdminProfileWidget({Key? key}) : super(key: key);

  @override
  State<AdminProfileWidget> createState() => _AdminProfileWidgetState();
}

class _AdminProfileWidgetState extends State<AdminProfileWidget> {
 UserViewModel viewModel = UserViewModel();

  @override
  void initState() {
    viewModel.getUserById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.kWhiteColor, elevation: 0,),
      backgroundColor: AppColors.kWhiteColor,
      body: BlocBuilder<GenericCubit<User>, GenericCubitState<User>>(
          bloc: viewModel.userCubit,
        builder: (context, state) {
          return Container(
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppSize.h10.ph,
                        Text("${state.data.name ?? ""}", style: AppStyles.kTextStyleHeader18,),
                        AppSize.h20.ph,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("معلومات التواصل", style: AppStyles.kTextStyle18,),
                            AppSize.h5.ph,
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.kMainColor)
                                ),
                                padding: EdgeInsets.all(10.sp),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("رقم الجوال | ${state.data.phone ?? ""}", style: AppStyles.kTextStyle18,),
                                        AppSize.h20.ph,
                                        Text("البريد الإلكتروني: ${state.data.email ?? ""}", style: AppStyles.kTextStyle18,),
                                      ],
                                    ),
                                  ],
                                )),

                          ],
                        ),

                        Row(
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ChangePasswordPage()));
                                },
                                child: Text("تغيير كلمة المرور", style: AppStyles.kTextStyle18,)),
                          ],
                        ),

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
          );
        }
      ),
    );
  }
}