import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/vistor/home/models/MissingModel.dart';
import 'package:template/features/vistor/home/vistor_home_viewmodel.dart';
import 'package:template/features/vistor/home/widgets/add_missings_page.dart';
import 'package:template/features/vistor/home/widgets/add_report_for_missing_person.dart';
import 'package:template/features/vistor/reports/widgets/ReportWidget.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';

class ReportsPage extends StatefulWidget {
  final bool isAll;
  const ReportsPage({Key? key, required this.isAll}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  VistorHomeViewModel viewModel = VistorHomeViewModel();

  bool isPersons = true;

  @override
  void initState() {
    if(widget.isAll){
      viewModel.getAllMissings();
    }else{
      viewModel.getAllMissingsForEveryUserID();
    }
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
      body: BlocBuilder<GenericCubit<List<MissingModel>>, GenericCubitState<List<MissingModel>>>(
        bloc: viewModel.missings,
        builder: (context, state) {
          List<MissingModel> missings = [];
          if(isPersons){
            state.data.forEach((e){
              if(e.type == 1){
                missings.add(e);
              }
            });
          } else {
            state.data.forEach((e){
              if(e.type == 2){
                missings.add(e);
              }
            });
          }
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
                          title: "قائمة البلاغات",
                          radius: 20,
                          textSize: 14.sp,
                          onClick: (){}),
                    ),
                  ],
                ),
                AppSize.h20.ph,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButton(title: " الأشخاص",
                        textSize: 14.sp,
                        width: 130.sp,
                        radius: 20,
                        btnColor: isPersons ? AppColors.kMainColor: AppColors.kbackLoginColor,
                        onClick: (){
                          setState(() {
                            isPersons = true;
                          });
                        }),
                    CustomButton(title: " المفقودات",
                        textSize: 14.sp,
                        width: 130.sp,
                        radius: 20,
                        btnColor: !isPersons ? AppColors.kMainColor: AppColors.kbackLoginColor,
                        onClick: (){
                      setState(() {
                        isPersons = false;
                      });
                        }),
                  ],
                ),
                AppSize.h20.ph,

                InkWell(
                  onTap: (){
                    if(isPersons){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReportForMissingPerson(viewModel: viewModel,)));
                    }else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMissingsPage(viewModel: viewModel,)));
                    }
                  },
                  child: Row(
                    children: [
                      Image.asset(Resources.add61, height: 35.sp,),
                      AppSize.h10.pw,
                      Expanded(
                        child: Text("إضافة بلاغ جديد", style: AppStyles.kTextStyle16,),
                      )
                    ],
                  ),
                ),
                AppSize.h20.ph,

                ListView.separated(
                  shrinkWrap: true,
                    itemBuilder: (context, index){
                      return ReportWidget(missingModel: missings[index],);
                    },
                    separatorBuilder: (context, index){
                      return AppSize.h10.ph;
                    },
                    itemCount: missings.length
                )


              ],
            ),
          );
        }
      ),
    );
  }
}
