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
import 'package:template/shared/resources.dart';
import 'package:template/shared/ui/componants/custom_button.dart';
import 'package:template/shared/ui/componants/custom_field.dart';
import 'package:template/shared/ui/componants/loading_widget.dart';

class SuplierRegisterPage extends StatefulWidget {
  final User? user;
  const SuplierRegisterPage({Key? key, this.user}) : super(key: key);

  @override
  State<SuplierRegisterPage> createState() => _SuplierRegisterPageState();
}

class _SuplierRegisterPageState extends State<SuplierRegisterPage> {
  UserViewModel viewModel = UserViewModel();

  @override
  void initState() {
    if(widget.user != null){
      viewModel.fillSupplierData(widget.user!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left:20.sp, right:20.sp, bottom:20.sp),
        child: Form(
          key: viewModel.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  Resources.logo,
                  height: 150.sp, // Adjust the size of the logo as needed
                ),
                AppSize.h10.ph, // Space between the logo and the title
                Text(
                  widget.user != null ? "Update": "Register/ Supplier",
                  style: AppStyles.kTextStyleHeader26.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.kBlackColor,
                  ),
                ),
                AppSize.h40.ph,
                CustomField(
                  controller: viewModel.name,
                  hint: "Name",
                  validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                ),
                AppSize.h20.ph,
                CustomField(
                  controller: viewModel.email,
                  hint: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!viewModel.isValidEmail(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                AppSize.h20.ph,
                widget.user == null? CustomField(
                  controller: viewModel.password,
                  hint: "Password",
                  obsecure: true,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your password' : null,
                ): const SizedBox(),
                widget.user == null? AppSize.h20.ph : const SizedBox(),
                CustomField(
                  controller: viewModel.phone,
                  hint: "Contact info",
                  validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                ),
                AppSize.h20.ph,
                CustomField(
                  controller: viewModel.company_name,
                  hint: "Company name",
                  validator: (value) => value!.isEmpty ? 'Please enter your company name' : null,
                ),
                AppSize.h20.ph,
                CustomField(
                  controller: viewModel.address,
                  hint: "Location",
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your address' : null,
                ),
                AppSize.h40.ph,
                BlocBuilder<GenericCubit<bool>,
                    GenericCubitState<bool>>(
                    bloc: viewModel.loading,
                    builder: (context, state) {
                      return state.data
                          ? const Loading()
                          : CustomButton(
                        title: widget.user != null ? "Update": "Register",
                        onClick: (){
                          if (widget.user != null){
                            viewModel.supplierUpdateProfile(widget.user!.id!);
                          }else{
                            viewModel.vistorRegister();
                          }
                        }
                    );
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
