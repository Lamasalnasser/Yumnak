import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/authentication/user_viewModel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';

class OrganziersLoginPage extends StatefulWidget {
  const OrganziersLoginPage({Key? key}) : super(key: key);

  @override
  State<OrganziersLoginPage> createState() => _OrganziersLoginPageState();
}

class _OrganziersLoginPageState extends State<OrganziersLoginPage> {
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
                child: Form(
                  key: viewModel.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSize.h10.ph,
                      Text("الرقم الوظيفي", style: AppStyles.kTextStyle16.copyWith(
                        color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.jobId,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        // hint: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your job id';
                          }
                          return null;
                        },
                      ),
                      AppSize.h20.ph,
                      Text("كلمة المرور", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.password,
                        fillColor: AppColors.kWhiteColor,
                        obsecure: true,
                        borderRaduis: 40,
                        // hint: "Email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      AppSize.h5.ph,
                      InkWell(
                        onTap: () => UI.push(AppRoutes.forgetPasswordWidget),
                        child: Text("نسيت كلمة المرور؟ إعادة إنشاء كلمة المرور", style: AppStyles.kTextStyle10.copyWith(
                          color: AppColors.kWhiteColor
                        ),),
                      ),
                      AppSize.h20.ph,
                      BlocBuilder<GenericCubit<bool>,
                          GenericCubitState<bool>>(
                          bloc: viewModel.loading,
                          builder: (context, state) {
                            return state.data
                                ? const Loading()
                                : CustomButton(
                              title: "تسجيل دخول",
                              textSize: 15.sp,
                              radius: 40,
                              onClick: (){
                                viewModel.login();
                              }
                          );
                        }
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
