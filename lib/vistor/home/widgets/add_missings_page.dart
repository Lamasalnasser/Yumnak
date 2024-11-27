import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/vistor/home/vistor_home_viewmodel.dart';
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

class AddMissingsPage extends StatefulWidget {
  final VistorHomeViewModel viewModel;
  const AddMissingsPage({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<AddMissingsPage> createState() => _AddMissingsPageState();
}

class _AddMissingsPageState extends State<AddMissingsPage> {

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height- 100,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: widget.viewModel.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("الإبلاغ عن مفقودات", style: AppStyles.kTextStyleHeader20,),
                AppSize.h40.ph,
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.kbackLoginColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                      )
                  ),
                  padding: EdgeInsets.all(20.sp),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.kWhiteColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.all(10.sp),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomField(
                            controller: widget.viewModel.description,
                            hint: "اكتب وصف البلاغ هنا...",
                            hintStyle: AppStyles.kTextStyle14,
                            fillColor: AppColors.kWhiteColor,
                            maxLines: 6,
                          ),
                          AppSize.h20.ph,
                          CustomField(
                            controller: widget.viewModel.fullName,
                            hint: "الاسم الكامل",
                            hintStyle: AppStyles.kTextStyle14,
                            fillColor: AppColors.kWhiteColor,
                          ),

                          AppSize.h10.ph,
                          CustomField(
                            controller: widget.viewModel.contact_number,
                            hint: "رقم التواصل",
                            hintStyle: AppStyles.kTextStyle14,
                            fillColor: AppColors.kWhiteColor,
                            keyboardType: TextInputType.phone,
                          ),

                          AppSize.h10.ph,
                          CustomField(
                            controller: widget.viewModel.identifier_number,
                            hint: "رقم الهوية/الإقامة",
                            hintStyle: AppStyles.kTextStyle14,
                            fillColor: AppColors.kWhiteColor,
                            keyboardType: TextInputType.phone,
                          ),

                          AppSize.h10.ph,

                          CustomField(
                            controller: TextEditingController(),
                            hint: "إرفاق صورة ",
                            readOnly: true,
                            hintStyle: AppStyles.kTextStyle14,
                            fillColor: AppColors.kWhiteColor,
                            keyboardType: TextInputType.phone,
                            suffix: BlocBuilder<GenericCubit<File?>, GenericCubitState<File?>>(
                                bloc: widget.viewModel.imageFile,
                                builder: (s, state){
                                  return Padding(
                                    padding: EdgeInsets.all(5.sp),
                                    child: InkWell(
                                      onTap:  widget.viewModel.pickImage,
                                      child: state.data != null ?
                                      Container(
                                        height: 30.sp,
                                        width: 30.sp,
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
                            onTap: (){
                              widget.viewModel.pickImage();
                            },
                          ),

                          AppSize.h40.ph,

                          BlocBuilder<GenericCubit<bool>,
                              GenericCubitState<bool>>(
                              bloc: widget.viewModel.loading,
                              builder: (context, state) {
                                return state is GenericLoadingState || state.data
                                    ? const Loading()
                                    : CustomButton(
                                  title: "إرسال",
                                  width: 150.sp,
                                  textSize: 12.sp,
                                  radius: 20,
                                  onClick: (){
                                   widget.viewModel.addMissing(2);
                                  });
                            }
                          )
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
