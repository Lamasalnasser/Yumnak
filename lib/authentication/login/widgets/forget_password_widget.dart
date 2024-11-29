import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/authentication/user_viewModel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';

class ForgetPasswordWidget extends StatefulWidget {
  const ForgetPasswordWidget({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordWidget> createState() => _ForgetPasswordWidgetState();
}

class _ForgetPasswordWidgetState extends State<ForgetPasswordWidget> {
  UserViewModel viewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.sp),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 10.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "اعادة انشاء كلمة المرور",
                style: AppStyles.kTextStyleHeader26.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.kMainColor,
                ),
              ),
              AppSize.h20.ph,
              Container(
                decoration: BoxDecoration(
                    color: AppColors.kbackLoginColor,
                    borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.all(20.sp),
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSize.h10.ph,
                      Text("البريد الالكتروني", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.name,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        // hint: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      AppSize.h5.ph,
                      InkWell(
                        onTap: (){},
                        child: Text("تحقق من البريد الالكتروني", style: AppStyles.kTextStyle10.copyWith(
                            color: AppColors.kWhiteColor
                        ),),
                      ),

                      AppSize.h20.ph,
                      Text("كلمة المرور الجديدة", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.newPassword,
                        fillColor: AppColors.kWhiteColor,
                        obsecure: true,
                        borderRaduis: 40,
                        // hint: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!viewModel.isValidEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),

                      AppSize.h20.ph,
                      Text("تأكيد كلمة المرور الجديدة", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.confirm_password,
                        fillColor: AppColors.kWhiteColor,
                        obsecure: true,
                        borderRaduis: 40,
                        // hint: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!viewModel.isValidEmail(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      AppSize.h5.ph,
                      InkWell(
                        onTap: (){},
                        child: Text("نسيت كلمة المرور؟ إعادة إنشاء كلمة المرور", style: AppStyles.kTextStyle10.copyWith(
                            color: AppColors.kWhiteColor
                        ),),
                      ),
                      AppSize.h20.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                              title: "انشاء",
                              textSize: 15.sp,
                              width: 100.sp,
                              radius: 40,
                              onClick: (){
                                viewModel.loginVistor();
                              }
                          ),
                        ],
                      ),
                      AppSize.h100.ph,
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
