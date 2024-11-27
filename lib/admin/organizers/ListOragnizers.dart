import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/admin/organizers/widgets/OrganizerDetailsPage.dart';
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
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';


class ListOragnizers extends StatefulWidget {
  const ListOragnizers({Key? key}) : super(key: key);

  @override
  State<ListOragnizers> createState() => _ListOragnizersState();
}

class _ListOragnizersState extends State<ListOragnizers> {
  UserViewModel viewModel = UserViewModel();

  @override
  void initState() {
    viewModel.getAllUserByType(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kWhiteColor,
        elevation: 0,
        title: CustomField(
          controller: TextEditingController(),
          fillColor: AppColors.kTextEditColor,
          borderColor: AppColors.kTextEditColor,
          borderRaduis: 40,
          prefix: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(Resources.search, height: 25.sp,),
          ),
        ),
      ),
      backgroundColor: AppColors.kWhiteColor,
      body: BlocBuilder<GenericCubit<List<User>>, GenericCubitState<List<User>>>(
          bloc: viewModel.userByTypesCubit,
          builder: (context, state) {
            return state is GenericLoadingState ?
            const Loading():
            Container(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: (){},
                          child: Image.asset(Resources.filter, height: 25.sp,)),
                      AppSize.h10.pw,
                      Expanded(
                        child: CustomButton(
                            title: "قائمة المنظمين",
                            radius: 20,
                            textSize: 14.sp,
                            onClick: (){}),
                      ),
                    ],
                  ),

                  AppSize.h20.ph,

                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrganizerDetailsPage(viewModel: viewModel, user: state.data[index],)));
                          },
                          child: Card(
                            color: AppColors.kWhiteColor,elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.all(10.sp),
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(90),
                                      child: Image.memory(
                                          base64Decode(state.data[index].image ?? ""),
                                        height: 70.sp,
                                        width: 70.sp,
                                        fit: BoxFit.cover,
                                      )),
                                  AppSize.h10.pw,
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(state.data[index].name ?? "", style: AppStyles.kTextStyle18,),
                                        Text(state.data[index].email ?? "", style: AppStyles.kTextStyle14,),
                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    ),
                                  ),
                                  AppSize.h10.pw,
                                  Icon(Icons.arrow_forward_rounded)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index){
                        return AppSize.h10.ph;
                      },
                      itemCount: state.data.length
                  )


                ],
              ),
            );
          }
      ),
    );
  }
}