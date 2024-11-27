import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/authentication/login/customer_login_page.dart';
import 'package:template/features/vistor/home/models/MissingModel.dart';
import 'package:template/features/vistor/reports/widgets/report_details.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';

class ReportWidget extends StatelessWidget {
  final MissingModel missingModel;
  const ReportWidget({Key? key, required this.missingModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportDetailsPage(missingModel: missingModel,)));
      },
      child: Card(
        color: AppColors.kWhiteColor,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Row(
            children: [
              Container(
                height: 50.sp,
                width: 50.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kbackLoginColor
                ),
                alignment: Alignment.center,
                child: Text(missingModel.fullName?.split("").first ?? "", style: AppStyles.kTextStyle22.copyWith(
                  color: AppColors.kWhiteColor
                ),),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppSize.h10.pw,
                        Container(
                          height: 15.sp,
                          width: 15.sp,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.kbackLoginColor
                          ),
                        ),
                        AppSize.h10.pw,
                        Expanded(child: Text(missingModel.description ?? "", maxLines: 1, style: AppStyles.kTextStyle16,)),
                        Spacer(),
                        Icon(Icons.arrow_forward_outlined, size: 30.sp,)
                      ],
                    ),
                    Divider(),
                    Text("بلاغ رقم ${missingModel.id}", maxLines: 1, style: AppStyles.kTextStyle18,),
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
