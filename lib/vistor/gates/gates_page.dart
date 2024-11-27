import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/vistor/gates/widgets/GateCard.dart';
import 'package:template/features/vistor/gates_maps/gate_maps_viewModel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';

class GatesPage extends StatefulWidget {
  const GatesPage({Key? key}) : super(key: key);

  @override
  State<GatesPage> createState() => _GatesPageState();
}

class _GatesPageState extends State<GatesPage> {
  GateMapsViewModel viewModel = GateMapsViewModel();

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

            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index){
                  return GateCard(place: viewModel.places[index],);
                },
                separatorBuilder: (context, index){
                  return AppSize.h10.ph;
                },
                itemCount: viewModel.places.length)


          ],
        ),
      ),
    );
  }
}
