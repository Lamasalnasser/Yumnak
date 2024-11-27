import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/vistor/gates_maps/gates_maps_page.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';

class BathRoomCard extends StatelessWidget {
  const BathRoomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kWhiteColor,
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.all(10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text("مرفق رقم 7أ غرب", style: AppStyles.kTextStyleHeader16.copyWith(
                color: AppColors.kMainColor
              ),),
            ),
            AppSize.h10.pw,

            CustomButton(
                title: "مغلقة",
                btnColor: AppColors.kbackLoginColor,
                width: 70,
                textSize: 12.sp,
                onClick: (){}),
            AppSize.h10.pw,
            Column(
              children: [
                Text("تبعد عنك", style: AppStyles.kTextStyleHeader12.copyWith(
                    color: AppColors.kMainColor
                ),),
                Text("٠.٣كم", style: AppStyles.kTextStyleHeader10.copyWith(
                    color: AppColors.kMainColor
                ),),
              ],
            ),
            AppSize.h10.pw,
            Column(
              children: [
                Text("الاتجاهات", style: AppStyles.kTextStyleHeader12.copyWith(
                    color: AppColors.kMainColor
                ),),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MapsPage()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.kbackLoginColor,
                        shape: BoxShape.circle
                      ),
                      padding: EdgeInsets.all(5.sp),
                      child: Image.asset(Resources.book, height: 10.sp,)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
