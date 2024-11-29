import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/authentication/user_viewModel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';
import 'package:template/shared/util/ui.dart';
import 'package:template/shared/widgets/CustomAppBarNotAuth.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  UserViewModel viewModel = UserViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.sp),
          child: Form(
            key: viewModel.formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: Column(
                children: [
                  Text(
                    "تسجيل دخول",
                    style: AppStyles.kTextStyleHeader26.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.kMainColor,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.kbackLoginColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.all(20.sp),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSize.h20.ph,
                        Text("كلمة المرور الحالية", style: AppStyles.kTextStyle16.copyWith(
                            color: AppColors.kWhiteColor
                        ),),
                        AppSize.h5.ph,
                        CustomField(
                          controller: viewModel.currentPassword,
                          obsecure: true,
                          fillColor: AppColors.kWhiteColor,
                          borderRaduis: 40,
                        ),
                        AppSize.h20.ph,
                        Text("كلمة المرور الجديدة", style: AppStyles.kTextStyle16.copyWith(
                            color: AppColors.kWhiteColor
                        ),),
                        AppSize.h5.ph,
                        CustomField(
                          controller: viewModel.newPassword,
                          obsecure: true,
                          fillColor: AppColors.kWhiteColor,
                          borderRaduis: 40,
                        ),
                        AppSize.h20.ph,
                        Text("تأكيد كلمة المرور الجديدة", style: AppStyles.kTextStyle16.copyWith(
                            color: AppColors.kWhiteColor
                        ),),
                        AppSize.h5.ph,
                        CustomField(
                          controller: viewModel.newPasswordConfirmation,
                          obsecure: true,
                          fillColor: AppColors.kWhiteColor,
                          borderRaduis: 40,
                        ),

                        AppSize.h40.ph,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BlocBuilder<GenericCubit<bool>,
                                GenericCubitState<bool>>(
                                bloc: viewModel.loading,
                                builder: (context, state) {
                                  return  state.data
                                      ? const SizedBox(width: 40, height: 25, child: Loading())
                                      : CustomButton(
                                    title: "تغيير",
                                    width: 120.sp,
                                    radius: 40,
                                    onClick: (){
                                      viewModel.updatePassword();
                                    },
                                  );
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
