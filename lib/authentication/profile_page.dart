import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/features/authentication/models/user.dart';
import 'package:template/features/authentication/user_viewModel.dart';
import 'package:template/features/authentication/widgets/ProfileItem.dart';
import 'package:template/features/authentication/widgets/change_password_page.dart';
import 'package:template/shared/app_size.dart';
import 'package:template/shared/constants/colors.dart';
import 'package:template/shared/extentions/padding_extentions.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/ui.dart';
import 'package:template/shared/widgets/CustomAppBarNotAuth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserViewModel viewModel = UserViewModel();
  @override
  void initState() {
    viewModel.getUserById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarWithoutBack(context, title: "Profile"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:BlocBuilder<GenericCubit<User>,
            GenericCubitState<User>>(
          bloc: viewModel.userCubit,
          builder: (context, state) {
            var profile = state.data;
            return ListView(
              children: [
                ProfileItem('Name', profile.name),
                ProfileItem('Contact Info', profile.contact_info),
                ProfileItem('Company Name', profile.company_name),
                ProfileItem('Email', profile.email),
                ProfileItem('Phone', profile.phone),
                ProfileItem('Address', profile.address),
                ProfileItem('Specialization', profile.spcialization),
                AppSize.h30.ph,
                CustomButton(title: "Edit profile", onClick: (){
                  // if(profile.type == 1 )
                    // UI.push(AppRoutes.suplierRegisterPage , arguments: profile);
                  // else if(profile.type == 4 )
                    // UI.push(AppRoutes.contractorRegisterPage , arguments: profile);
                  // else if(profile.type == 3)
                    // UI.push(AppRoutes.consultationRegisterPage, arguments: profile);
                  // else
                    // UI.push(AppRoutes.customerRegisterPage, arguments: profile);
                }),

                AppSize.h10.ph,
                CustomButton(title: "Edit password",
                    btnColor: AppColors.kGreyColor,
                    onClick: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
                }),

                AppSize.h10.ph,
                CustomButton(title: "Logout",
                    btnColor: AppColors.redColor757,
                    onClick: (){
                  PrefManager.clearUserData();
                  UI.pushWithRemove(AppRoutes.toggleBetweenUsers);
                })
              ],
            );
          }
        ),
      ),
    );
  }
}
