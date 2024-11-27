import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:template/features/vistor/gates_maps/gate_maps_viewModel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';



class MapsPage extends StatefulWidget {
  const MapsPage({Key? key}) : super(key: key);

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late GoogleMapController mapController;
  GateMapsViewModel viewModel = GateMapsViewModel();

  getData() async{
    viewModel.loadMarkers(await viewModel.getAllCoffeeShops());
  }

  @override
  void initState() {
    super.initState();
    // Load markers into the Cubit for Eastern Saudi cities
   getData();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
      body: Column(
        children: [
          AppSize.h20.ph,
          Text("باب الفتح", style: AppStyles.kTextStyleHeader26.copyWith(
              color: AppColors.kMainColor
          ),),
          AppSize.h20.ph,
          Padding(
            padding: EdgeInsets.all(10.sp),
            child: Card(
              elevation: 10,
              color: AppColors.kWhiteColor,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: BlocBuilder<GenericCubit<Set<Marker>>, GenericCubitState<Set<Marker>>>(
                  bloc: viewModel.markers, // Provide the Cubit
                  builder: (context, state) {
                    if (state is GenericLoadingState) {
                      return Loading();
                    } else if (state.data.isNotEmpty) {
                      return GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(21.4212925, 39.8241821), // Centered on Dammam
                          zoom: 16.0,
                        ),
                        markers: state.data, // Use the loaded markers
                      );
                    } else {
                      return Center(child: Text('No markers available'));
                    }
                  },
                ),
              ),
            ),
          ),
          AppSize.h100.ph,
          CustomButton(title: "عرض الاتجاه",
              width: 250.sp,
              textSize: 14.sp,
              radius: 40,
              onClick: (){})
        ],
      ),
    );
  }
}
