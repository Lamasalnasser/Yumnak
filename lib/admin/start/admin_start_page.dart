
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/admin/profile/AdminProfileWidget.dart';
import 'package:template/features/authentication/profile_page.dart';
import 'package:template/features/organizer/profile/OrganizerProfileWidget.dart';
import 'package:template/features/vistor/home/vistor_home_page.dart';
import 'package:template/features/vistor/profile/VistorProfileWidget.dart';
import 'package:template/features/vistor/settings/VistorSettingsWidget.dart';
import 'package:template/features/vistor/start/vistor_start_viewModel.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/constants/styles.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/resources.dart';
import 'package:template/shared/widgets/CustomAppBarNotAuth.dart';


GlobalKey<ScaffoldState> startScaffoldKey = GlobalKey();

class AdminStartPage extends StatefulWidget {
  const AdminStartPage({Key? key}) : super(key: key);

  @override
  State<AdminStartPage> createState() => _AdminStartPageState();
}

class _AdminStartPageState extends State<AdminStartPage> {
  SupplierStartViewModel startViewModel = SupplierStartViewModel();

  List<Widget> pages = [];

  @override
  void initState() {
    pages = [
      const VistorSettingsWidget(),
      const VistorHomePage(),
      const AdminProfileWidget()
    ];
    super.initState();
  }


  late NavigatorState _navigator;

  @override
  void didChangeDependencies() {
    _navigator = Navigator.of(context);
    super.didChangeDependencies();
  }

  NavigatorState of(BuildContext context, {bool rootNavigator = false}) {
    NavigatorState? navigator;
    if (context is StatefulElement && context.state is NavigatorState) {
      navigator = context.state as NavigatorState;
    }
    if (rootNavigator) {
      navigator =
          context.findRootAncestorStateOfType<NavigatorState>() ?? navigator;
    } else {
      navigator =
          navigator ?? context.findAncestorStateOfType<NavigatorState>();
    }
    return navigator!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenericCubit<int>, GenericCubitState<int>>(
      bloc: startViewModel.currentPageCubit,
      builder: (context, state) {
        return Scaffold(
          key: startScaffoldKey,
          body: pages[state.data],
          backgroundColor: AppColors.kWhiteColor,
          bottomSheet: Container(
            height: AppSize.navBarHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.kBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Material(
              shadowColor: AppColors.kWhiteColor,
              elevation: 100,
              color: AppColors.kBottomNAVBARColor,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    buildBottomNavItem(Resources.settings, 0, state.data),
                    buildBottomNavItem(Resources.home, 1, state.data),
                    buildBottomNavItem(Resources.user, 2, state.data)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBottomNavItem(String icon, int index, int currentState) {
    return InkWell(
      onTap: () {
        startViewModel.currentPageCubit.onUpdateData(index);
      },
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: currentState == index ? AppColors.kbackLoginColor : null
          ),
          height: 40.sp,width: 40.sp,
          padding: EdgeInsets.all(7.5.sp),
          child: Image.asset(icon, color: AppColors.kWhiteColor, height: 25.sp,width: 20.sp,)),
    );
  }
}