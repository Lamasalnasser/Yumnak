import 'dart:convert';

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
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';

class OrganizerDetailsPage extends StatefulWidget {
  final UserViewModel viewModel;
  final User user;
  const OrganizerDetailsPage({Key? key, required this.viewModel, required this.user}) : super(key: key);

  @override
  State<OrganizerDetailsPage> createState() => _OrganizerDetailsPageState();
}

class _OrganizerDetailsPageState extends State<OrganizerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.kWhiteColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height- 100.sp,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 75.sp),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.kbackLoginColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)
                            )
                        ),
                        height: MediaQuery.of(context).size.height *0.8,
                        width: MediaQuery.of(context).size.width,
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

                                AppSize.h85.ph,

                                Text("${widget.user.name ?? ""}", style: AppStyles.kTextStyleHeader18,),
                                AppSize.h40.ph,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("الجنس: ${widget.user.gender ?? ""}", style: AppStyles.kTextStyle12,),
                                          Text("العمر: ${DateTime.now().year - int.parse(widget.user.dateOfBirth?.split("/").last ?? "2010")}", style: AppStyles.kTextStyle12,),
                                        ],
                                      ),
                                    ),
                                    AppSize.h10.pw,
                                    Container(
                                      height: 40,
                                      width: 2,
                                      color: AppColors.kMainColor,
                                    ),
                                    AppSize.h10.pw,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("الرقم الوظيفي: ${widget.user.jobId ?? ""}", style: AppStyles.kTextStyle12,),
                                          Text("الهوية الوطنية: ${widget.user.nationalId}", style: AppStyles.kTextStyle12,),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

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
                                                Text("رقم الجوال | ${widget.user.phone ?? ""}", style: AppStyles.kTextStyle18,),
                                                AppSize.h20.ph,
                                                Text("البريد الإلكتروني: ${widget.user.email ?? ""}", style: AppStyles.kTextStyle18,),
                                              ],
                                            ),
                                          ],
                                        )),

                                  ],
                                ),

                                AppSize.h60.ph,
                                BlocBuilder<GenericCubit<bool>,
                                    GenericCubitState<bool>>(
                                    bloc: widget.viewModel.loading,
                                    builder: (context, state) {
                                      return state is GenericLoadingState || state.data
                                          ? const Loading()
                                          : CustomButton(
                                          title: widget.user.status == "Unblocked" ? "حظر المنظم": "الغاء الحظر",
                                          width: 150.sp,
                                          textSize: 12.sp,
                                          radius: 20,
                                          onClick: (){
                                            // Unblocked
                                            // Blocked
                                            if(widget.user.status == "Unblocked"){
                                              widget.user.status = "Blocked";
                                            } else{
                                              widget.user.status = "Unblocked";
                                            }
                                            widget.viewModel.updateProfileStatus(widget.user);
                                          });
                                    }
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: Image.memory(
                            base64Decode(widget.user.image ?? ""),
                            height: 150.sp,
                            width: 150.sp,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
