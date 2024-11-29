import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/authentication/models/user.dart';
import 'package:template/features/authentication/user_viewModel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/models/user_model.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';

class OrganizerRegisterPage extends StatefulWidget {
  final User? user;
  const OrganizerRegisterPage({Key? key, this.user}) : super(key: key);

  @override
  State<OrganizerRegisterPage> createState() => _OrganizerRegisterPageState();
}

class _OrganizerRegisterPageState extends State<OrganizerRegisterPage> {
  UserViewModel viewModel = UserViewModel();

  @override
  void initState() {
    if(widget.user != null){
      viewModel.fillCustomerData(widget.user!);
    }
    super.initState();
  }

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
                  "إنشاء حساب",
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

                      Text("الاسم كامل", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                          controller: viewModel.name,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                      ),
                      AppSize.h20.ph,

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("تاريخ الميلاد", style: AppStyles.kTextStyle16.copyWith(
                                  color: AppColors.kWhiteColor
                                ),),
                                AppSize.h5.ph,
                                CustomField(
                                    controller: viewModel.dobirth,
                                  fillColor: AppColors.kWhiteColor,
                                  borderRaduis: 40,
                                  onTap:  () async {
                                    DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      viewModel.dobirth.text =
                                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                    }
                                  },
                                  validator: (value) => value!.isEmpty ? 'Please enter your DOB' : null,
                                ),
                              ],
                            ),
                          ),
                          AppSize.h10.pw,
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("الجنس", style: AppStyles.kTextStyle16.copyWith(
                                  color: AppColors.kWhiteColor
                                ),),
                                AppSize.h5.ph,
                                BlocBuilder<GenericCubit<String?>, GenericCubitState<String?>>(
                                  bloc: viewModel.selectedGender,
                                  builder: (context, state) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        value: state.data,
                                        items: const [
                                          DropdownMenuItem(value: "male", child: Text("ذكر")),
                                          DropdownMenuItem(value: "female", child: Text("أنثى")),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            viewModel.selectedGender.onUpdateData(value);
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "هذا الحقل مطلوب";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(border: InputBorder.none),
                                        hint: Text("تحديد"),
                                      ),
                                    );
                                  }
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      AppSize.h20.ph,
                      Text("البريد الإلكتروني", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      CustomField(
                          controller: viewModel.email,
                        keyboardType: TextInputType.emailAddress,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
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
                      AppSize.h5.ph, Text("رقم الجوال", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.phone,
                        keyboardType: TextInputType.phone,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                      ),

                      AppSize.h20.ph,
                      AppSize.h5.ph, Text("الهوية الوطنية", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.nationalId,
                        keyboardType: TextInputType.phone,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        validator: (value) => value!.isEmpty ? 'Please enter your national number' : null,
                      ),

                      AppSize.h20.ph,
                      AppSize.h5.ph, Text("الرقم الوظيفي", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      CustomField(
                        controller: viewModel.jobId,
                        keyboardType: TextInputType.phone,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        validator: (value) => value!.isEmpty ? 'Please enter your job id' : null,
                      ),

                      AppSize.h20.ph,

                      AppSize.h5.ph, Text("كلمة المرور", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      widget.user == null? CustomField(
                        controller: viewModel.password,
                        keyboardType: TextInputType.visiblePassword,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        obsecure: true,
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your password' : null,
                      ): const SizedBox(),
                      widget.user == null? AppSize.h20.ph : const SizedBox(),


                      Text("تأكيد كلمة المرور", style: AppStyles.kTextStyle16.copyWith(
                          color: AppColors.kWhiteColor
                      ),),
                      AppSize.h5.ph,
                      widget.user == null? CustomField(
                        controller: viewModel.confirm_password,
                        keyboardType: TextInputType.visiblePassword,
                        fillColor: AppColors.kWhiteColor,
                        borderRaduis: 40,
                        obsecure: true,
                        validator: (value) =>
                        value!.isEmpty ? 'Please enter your password' : null,
                      ): const SizedBox(),
                      widget.user == null? AppSize.h20.ph : const SizedBox(),

                      AppSize.h20.ph,

                      InkWell(
                        onTap: (){
                          viewModel.pickImage();
                        },
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.kWhiteColor,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.asset(Resources.upload, height: 20.sp,),
                              Text("الصورة الشخصية", style: AppStyles.kTextStyle16),
                            ],
                          ),
                        ),
                      ),

                      BlocBuilder<GenericCubit<File?>, GenericCubitState<File?>>(
                          bloc: viewModel.imageFile,
                          builder: (s, state){
                            return Padding(
                              padding: EdgeInsets.all(5.sp),
                              child: InkWell(
                                  onTap:  viewModel.pickImage,
                                  child: state.data != null ?
                                  Container(
                                    height: 100.sp,
                                    width: 100.sp,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(state.data!),
                                            fit: BoxFit.contain
                                        )
                                    ),
                                    padding: EdgeInsets.all(10.sp),
                                  ):
                                  const SizedBox()
                              ),
                            );
                          }
                      ),


                      AppSize.h40.ph,
                      BlocBuilder<GenericCubit<bool>,
                          GenericCubitState<bool>>(
                          bloc: viewModel.loading,
                          builder: (context, state) {
                            return state.data
                                ? const Loading()
                                : CustomButton(
                              title: widget.user != null ? "تحديث": "إنشاء الحساب",
                              radius: 40,
                              onClick: (){
                                if (widget.user != null){
                                  viewModel.customerUpdateProfile(widget.user!.id!);
                                }else{
                                  viewModel.customerRegister();
                                }
                              }
                          );
                        }
                      ),
                    ],
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
