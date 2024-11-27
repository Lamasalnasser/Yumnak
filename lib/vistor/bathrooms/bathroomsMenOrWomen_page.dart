import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/vistor/bathrooms/bathrooms_page.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';

class BathRoomsMenOrWomenPage extends StatefulWidget {
  const BathRoomsMenOrWomenPage({Key? key}) : super(key: key);

  @override
  State<BathRoomsMenOrWomenPage> createState() => _BathRoomsMenOrWomenPageState();
}

class _BathRoomsMenOrWomenPageState extends State<BathRoomsMenOrWomenPage> {
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
            borderRaduis: 40
        ),
      ),
      backgroundColor: AppColors.kWhiteColor,
      body: Container(
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
                      title: "البوابات",
                      radius: 20,
                      textSize: 14.sp,
                      onClick: (){}),
                ),
              ],
            ),
            AppSize.h20.ph,
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BathroomsPage()));
              },
              child: Card(
                color: AppColors.kWhiteColor,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("المرافق الخاصة بالرجال", style: AppStyles.kTextStyleHeader16.copyWith(
                            color: AppColors.kMainColor
                        ),),
                      ),
                      AppSize.h10.pw,
                      Image.asset(Resources.man, height: 60.sp,),
                      AppSize.h30.pw,
                    ],
                  ),
                ),
              ),
            ),
            AppSize.h20.ph,
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => BathroomsPage()));
              },
              child: Card(
                color: AppColors.kWhiteColor,
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text("المرافق الخاصة بالنساء", style: AppStyles.kTextStyleHeader16.copyWith(
                            color: AppColors.kMainColor
                        ),),
                      ),
                      AppSize.h10.pw,
                      Image.asset(Resources.woman, height: 60.sp,),
                      AppSize.h30.pw,
                    ],
                  ),
                ),
              ),
            ),
            AppSize.h20.ph,


          ],
        ),
      ),
    );
  }
}
