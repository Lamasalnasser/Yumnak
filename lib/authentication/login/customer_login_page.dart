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

class CustomerLoginPage extends StatefulWidget {
  const CustomerLoginPage({Key? key}) : super(key: key);

  @override
  State<CustomerLoginPage> createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
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
                "تسجيل دخول",
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppSize.h10.ph,
                          Text("الاسم كاملا", style: AppStyles.kTextStyle16.copyWith(
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
                          AppSize.h20.ph,

                          Text("رقم الجوال", style: AppStyles.kTextStyle16.copyWith(
                            color: AppColors.kWhiteColor
                          ),),
                          AppSize.h5.ph,
                          CustomField(
                            controller: viewModel.phone,
                            fillColor: AppColors.kWhiteColor,
                            borderRaduis: 40,
                            keyboardType: TextInputType.phone,
                            // hint: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    AppSize.h20.ph,
                    CustomButton(
                        title: "أرسل رمز التحقق",
                        radius: 40,
                        textSize: 15.sp,
                        onClick: (){
                          viewModel.loginValidateAndGenerateCode();
                        }
                    ),
                    AppSize.h50.ph,
                    Text("أدخل رمز التحقق", style: AppStyles.kTextStyle16.copyWith(
                      color: AppColors.kWhiteColor
                    ),),
                    AppSize.h5.ph,
                    CustomField(
                      controller: viewModel.password,
                      fillColor: AppColors.kWhiteColor,
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
                    CustomButton(
                        title: "تسجيل دخول",
                        textSize: 15.sp,
                        radius: 40,
                        onClick: (){
                          viewModel.loginVistor();
                        }
                    ),
                    AppSize.h100.ph,
                    // InkWell(
                    //   // onTap: () => widget.type == 1? UI.push(AppRoutes.suplierRegisterPage):
                    //   // widget.type == 3? UI.push(AppRoutes.consultationRegisterPage):
                    //   // widget.type == 4?  UI.push(AppRoutes.contractorRegisterPage):
                    //   // UI.push(AppRoutes.customerRegisterPage),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text("Create new account", style: AppStyles.kTextStyle16),
                    //       Text(" Register", style: AppStyles.kTextStyle18.copyWith(
                    //           color: Colors.blue,
                    //           fontWeight: FontWeight.bold
                    //       ),),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
