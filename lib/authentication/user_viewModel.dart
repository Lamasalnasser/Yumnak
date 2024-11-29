import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/features/authentication/models/user.dart';
import 'package:template/shared/constants/collection_names.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/models/failure.dart';
import 'package:template/shared/models/user_model.dart';
import 'package:template/shared/network/firebase_helper.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/helper.dart';
import 'package:template/shared/util/ui.dart';
import 'package:uuid/uuid.dart';

class UserViewModel{
  FirebaseHelper firebaseHelper = FirebaseHelper();
  GenericCubit<User> userCubit = GenericCubit(User());
  GenericCubit<List<User>> userByTypesCubit = GenericCubit([]);
  GenericCubit<String?> selectedGender = GenericCubit(null);
  GenericCubit<bool> loading = GenericCubit(false);
  GenericCubit<File?> imageFile = GenericCubit(null);

  // login for both
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController(text: "");
  TextEditingController dobirth = TextEditingController(text: "");
  // TextEditingController email = TextEditingController(text: "intalio@gmail.com");
  TextEditingController email = TextEditingController(text: "");
  TextEditingController phone = TextEditingController(text: "");
  TextEditingController nationalId = TextEditingController(text: "");
  TextEditingController jobId = TextEditingController(text: "");
  TextEditingController company_name = TextEditingController(text: "");
  TextEditingController address = TextEditingController(text: "");
  TextEditingController spcialization = TextEditingController(text: "");
  // TextEditingController password = TextEditingController(text: "123456");
  TextEditingController password = TextEditingController(text: "");
  TextEditingController confirm_password = TextEditingController(text: "");
  TextEditingController currentPassword = TextEditingController(text: "");
  TextEditingController newPassword = TextEditingController(text: "");
  TextEditingController newPasswordConfirmation = TextEditingController(text: "");

  // Function to pick an image from the device
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.onUpdateData(File(pickedFile.path));
    }
  }


  loginValidateAndGenerateCode() async{
    if (!formKey.currentState!.validate()){
      return;
    }
    userCubit.onLoadingState();
    try{
      password.text = "123432";
    } on Failure catch (e) {
      userCubit.onErrorState(e);
    }
  }


  loginVistor() async{
    if (!formKey.currentState!.validate()){
      return;
    }
    userCubit.onLoadingState();
    try{
      User user = User();
      user.email = email.text;
      user.password = password.text;
      print("user.get() >>>>  ${user.toMapLogin()}");
      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "phone", phone.text);
      if (result.isNotEmpty) {
        var userData = result.first.data() as Map<String, dynamic>;
        if (userData['password'] == password.text) {
          // Successful login
          PrefManager.setCurrentUser(UserModel.fromJson(userData));
          UI.showMessage('Login successful Mr: ${userData['name']}');
          if(PrefManager.currentUser?.type == 1){
            UI.push(AppRoutes.vistorstartPage);
          }else if(PrefManager.currentUser?.type == 2){
            // UI.push(AppRoutes.customerStartPage);
          } else if(PrefManager.currentUser?.type == 3){
            // UI.push(AppRoutes.consultationStartPage);
          }
        } else {
          // Password incorrect
          UI.showMessage('Invalid code');
        }
      } else {
        // Email not found
        vistorRegister();
        // UI.showMessage('No user found with that email');
      }
      print("login.get() >>>> ");
      print(result.asMap());
    } on Failure catch (e) {
      userCubit.onErrorState(e);
    }
  }

  login() async{
    if (!formKey.currentState!.validate()){
      return;
    }
    loading.onLoadingState();
    loading.onUpdateData(true);
    userCubit.onLoadingState();
    try{
      User user = User();
      if(jobId.text.contains("@gmail.com")) {
        user.email = jobId.text;
      }else{
        user.jobId = jobId.text;
      }
      print(jobId.text);
      user.password = password.text;
      print("user.get() >>>>  ${user.toMapLogin()}");
      List<QueryDocumentSnapshot> result = jobId.text.contains("@gmail.com")? await firebaseHelper.searchDocuments(CollectionNames.usersTable, "email", jobId.text): await firebaseHelper.searchDocuments(CollectionNames.usersTable, "job_id", jobId.text);
      if (result.isNotEmpty) {
        var userData = result.first.data() as Map<String, dynamic>;
        if (userData['password'] == password.text) {
          // Successful login
          PrefManager.setCurrentUser(UserModel.fromJson(userData));
          UI.showMessage('Login successful Mr: ${userData['name']}');
          if(PrefManager.currentUser?.type == 2){
            UI.push(AppRoutes.organizerStartPage);
          } else if(PrefManager.currentUser?.type == 3){
            UI.push(AppRoutes.adminStartPage);
          }
          loading.onUpdateData(false);
        } else {
          // Password incorrect
          UI.showMessage('Invalid password');
          loading.onUpdateData(false);
        }
      } else {
        // Email not found
        loading.onUpdateData(false);
        UI.showMessage('No user found with that email');
      }
      print("login.get() >>>> ");
      print(result.asMap());
      loading.onUpdateData(false);
    } on Failure catch (e) {
      loading.onUpdateData(false);
      userCubit.onErrorState(e);
    }
  }

  customerRegister() async{
    if (!formKey.currentState!.validate()){
      return;
    }
    userCubit.onLoadingState();
    try{
      String userId = Uuid().v4(); // Generate a unique ID for the user

      User user = User();
      user.id = userId;
      user.name = name.text;
      user.email = email.text;
      user.password = password.text;
      user.address = address.text;
      user.phone = phone.text;
      user.gender = selectedGender.state.data;
      user.dateOfBirth = dobirth.text;
      user.jobId = jobId.text;
      user.nationalId = nationalId.text;
      user.status = "Unblocked";
      user.image = await Helper.fileToBase64(imageFile.state.data ?? File(""));
      user.type = 2;
      print("user.get() >>>>  ${user.toMap()}");
      loading.onUpdateData(true);
      bool emailUnique = await isEmailUnique(email.text);
      if (!emailUnique) {
        UI.showMessage('Email already exists. Please use a different email.');
        loading.onUpdateData(false);
        return;
      }

      QuerySnapshot? querySnapshot = await firebaseHelper.addDocumentWithSpacificDocID(CollectionNames.usersTable, userId, user.toMap());

      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "email", email.text);
      if(result.isNotEmpty){
        var userData = result.first.data() as Map<String, dynamic>;
        PrefManager.setCurrentUser(UserModel.fromJson(userData));
        UI.showMessage('register success');
        UI.push(AppRoutes.organizerStartPage);
      } else{
        UI.showMessage('register failed');
      }
      loading.onUpdateData(false);
      print("documentReference.get() >>>> ");
      print(querySnapshot?.docs.asMap());
    } on Failure catch (e) {
      userCubit.onErrorState(e);
    }
  }

  vistorRegister() async{
    if (!formKey.currentState!.validate()){
      return;
    }
    loading.onLoadingState();
    try{
      String userId = Uuid().v4(); // Generate a unique ID for the user

      User user = User();
      user.id = userId;
      user.name = name.text;
      user.password = password.text;
      user.phone = phone.text;
      user.type = 1;
      print("user.get() >>>>  ${user.toMapSupplier()}");

      loading.onUpdateData(true);
      bool emailUnique = await isEmailUnique(phone.text);
      if (!emailUnique) {
        UI.showMessage('Email already exists. Please use a different email.');
        loading.onUpdateData(false);
        return;
      }

      QuerySnapshot? querySnapshot = await firebaseHelper.addDocumentWithSpacificDocID(CollectionNames.usersTable, userId, user.toMapSupplier());

      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "phone", phone.text);
      if(result.isNotEmpty){
        var userData = result.first.data() as Map<String, dynamic>;
        PrefManager.setCurrentUser(UserModel.fromJson(userData));
        UI.showMessage('Login success');
        UI.push(AppRoutes.vistorstartPage);
      } else{
        UI.showMessage('Login failed');
      }
      loading.onUpdateData(false);
      print("documentReference.get() >>>> ");
      print(querySnapshot?.docs.asMap());
    } on Failure catch (e) {
      userCubit.onErrorState(e);
    }
  }


  contractorRegister() async{
    if (!formKey.currentState!.validate()){
      return;
    }
    loading.onLoadingState();
    try{
      String userId = Uuid().v4(); // Generate a unique ID for the user

      User user = User();
      user.id = userId;
      user.name = name.text;
      user.email = email.text;
      user.password = password.text;
      user.address = address.text;
      user.contact_info = phone.text;
      user.company_name = company_name.text;
      user.type = 4;
      print("user.get() >>>>  ${user.toMapSupplier()}");

      loading.onUpdateData(true);
      bool emailUnique = await isEmailUnique(email.text);
      if (!emailUnique) {
        UI.showMessage('Email already exists. Please use a different email.');
        loading.onUpdateData(false);
        return;
      }

      QuerySnapshot? querySnapshot = await firebaseHelper.addDocumentWithSpacificDocID(CollectionNames.usersTable, userId, user.toMapSupplier());

      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "email", email.text);
      if(result.isNotEmpty){
        var userData = result.first.data() as Map<String, dynamic>;
        PrefManager.setCurrentUser(UserModel.fromJson(userData));
        UI.showMessage('register success');
        // UI.push(AppRoutes.supplierStartPage);
      } else{
        UI.showMessage('register failed');
      }
      loading.onUpdateData(false);
      print("documentReference.get() >>>> ");
      print(querySnapshot?.docs.asMap());
    } on Failure catch (e) {
      userCubit.onErrorState(e);
    }
  }


  consultationRegister() async{
    if (!formKey.currentState!.validate()){
      return;
    }
    userCubit.onLoadingState();
    try{
      String userId = Uuid().v4(); // Generate a unique ID for the user

      User user = User();
      user.id = userId;
      user.name = name.text;
      user.email = email.text;
      user.password = password.text;
      user.address = address.text;
      user.phone = phone.text;
      user.spcialization = spcialization.text;
      user.type = 3;
      print("user.get() >>>>  ${user.toMapConsultation()}");

      loading.onUpdateData(true);

      bool emailUnique = await isEmailUnique(email.text);
      if (!emailUnique) {
        UI.showMessage('Email already exists. Please use a different email.');
        loading.onUpdateData(false);
        return;
      }

      QuerySnapshot? querySnapshot = await firebaseHelper.addDocumentWithSpacificDocID(CollectionNames.usersTable, userId, user.toMapConsultation());

      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "email", email.text);
      if(result.isNotEmpty){
        var userData = result.first.data() as Map<String, dynamic>;
        PrefManager.setCurrentUser(UserModel.fromJson(userData));
        UI.showMessage('register success');
        // UI.push(AppRoutes.consultationStartPage);
      } else{
        UI.showMessage('register failed');
      }

      loading.onUpdateData(false);

      print("documentReference.get() >>>> ");
      print(querySnapshot?.docs.asMap());
    } on Failure catch (e) {
      userCubit.onErrorState(e);
    }
  }

  getUserById() async{
    try{
      userCubit.onLoadingState();
      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "id", PrefManager.currentUser!.id);
      userCubit.onUpdateData(User.fromJson(result.first.data() as Map<String, dynamic>));
    }catch (e){
      print("get user by id exception $e");
    }
  }

  updatePassword() async{
    try{
      if (!formKey.currentState!.validate()){
        return;
      }
      if(newPassword.text != newPasswordConfirmation.text){
        UI.showMessage("New password should be like new password confirmation");
        return;
      }

      loading.onUpdateData(true);
      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "id", PrefManager.currentUser!.id);
      final userResult = User.fromJson(result.first.data() as Map<String, dynamic>);
      if(userResult.password != currentPassword.text){
        UI.showMessage("invalid current password please set it again");
        loading.onUpdateData(false);
      }else{
        userResult.password = newPassword.text;
        if(userResult.type == 1 || userResult.type == 4) {
          await firebaseHelper.updateDocument(CollectionNames.usersTable,
              PrefManager.currentUser!.id!, userResult.toMapSupplier());
          loading.onUpdateData(false);
        }
        if(userResult.type == 2) {
          await firebaseHelper.updateDocument(CollectionNames.usersTable,
              PrefManager.currentUser!.id!, userResult.toMap());
          loading.onUpdateData(false);
        }
        if(userResult.type == 3) {
          await firebaseHelper.updateDocument(CollectionNames.usersTable,
              PrefManager.currentUser!.id!, userResult.toMapConsultation());
          loading.onUpdateData(false);
        }
        UI.showMessage("Password updated successfully");
        UI.pop();
      }
    }catch (e){
      print("get user by id exception $e");
    }
  }

  bool isValidEmail(String email) {
    // Email validation regex pattern
    String pattern =
        r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  // Function to check if email is unique
  Future<bool> isEmailUnique(String e) async {
    List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "email", e);
    return result.isEmpty;
  }

  fillSupplierData(User u){
    name.text = u.name ?? "";
    email.text = u.email ?? "";
    address.text = u.address ?? "";
    password.text = u.password ?? "";
    phone.text = u.contact_info ?? "";
    company_name.text = u.company_name ?? "";
  }

  fillConsultationData(User u){
    name.text = u.name ?? "";
    email.text = u.email ?? "";
    address.text = u.address ?? "";
    password.text = u.password ?? "";
    phone.text = u.phone ?? "";
    spcialization.text = u.spcialization ?? "";
  }

  fillCustomerData(User u) async{
    name.text = u.name ?? "";
    email.text = u.email ?? "";
    phone.text = u.phone ?? "";
    address.text = u.address ?? "";
    password.text = u.password ?? "";
    jobId.text = u.jobId ?? "";
    dobirth.text = u.dateOfBirth ?? "";
    nationalId.text = u.nationalId ?? "";
    selectedGender.onUpdateData(u.gender);
    imageFile.onUpdateData(await Helper.base64ToFile(u.image ?? ""));
  }

  supplierUpdateProfile(String userId) async{
    if (!formKey.currentState!.validate()){
      return;
    }
    try{
      User user = User();
      user.id = userId;
      user.name = name.text;
      user.email = email.text;
      user.password = password.text;
      user.address = address.text;
      user.contact_info = phone.text;
      user.company_name = company_name.text;
      user.type = 1;
      print("user.get() >>>>  ${user.toMapSupplier()}");

      loading.onUpdateData(true);
      bool emailUnique = await isEmailUnique(email.text);
      if (!emailUnique) {
        await firebaseHelper.updateDocument(CollectionNames.usersTable, userId, user.toMapSupplier());
        UI.showMessage("Profile updated Successfully");
      }
      loading.onUpdateData(false);
    } on Failure catch (e) {
      loading.onErrorState(e);
    }
  }

  contractorUpdateProfile(String userId) async{
    if (!formKey.currentState!.validate()){
      return;
    }
    try{
      User user = User();
      user.id = userId;
      user.name = name.text;
      user.email = email.text;
      user.password = password.text;
      user.address = address.text;
      user.contact_info = phone.text;
      user.company_name = company_name.text;
      user.type = 4;
      print("user.get() >>>>  ${user.toMapSupplier()}");

      loading.onUpdateData(true);
      bool emailUnique = await isEmailUnique(email.text);
      if (!emailUnique) {
        await firebaseHelper.updateDocument(CollectionNames.usersTable, userId, user.toMapSupplier());
        UI.showMessage("Profile updated Successfully");
      }
      loading.onUpdateData(false);
    } on Failure catch (e) {
      loading.onErrorState(e);
    }
  }



  updateProfileStatus(User user) async{
    try{
      print("user.get() >>>>  ${user.toJson()}");

      loading.onUpdateData(true);
      await firebaseHelper.updateDocument(CollectionNames.usersTable, user.id ?? "", user.toMap());
      UI.showMessage("Organizer is ${user.status}");
      loading.onUpdateData(false);
    } on Failure catch (e) {
      loading.onErrorState(e);
    }
  }

  consultationUpdateProfile(String userId) async{
    if (!formKey.currentState!.validate()){
      return;
    }
    userCubit.onLoadingState();
    try{
      User user = User();
      user.id = userId;
      user.name = name.text;
      user.email = email.text;
      user.password = password.text;
      user.address = address.text;
      user.phone = phone.text;
      user.spcialization = spcialization.text;
      user.type = 3;
      print("user.get() >>>>  ${user.toMapConsultation()}");

      loading.onUpdateData(true);
      bool emailUnique = await isEmailUnique(email.text);
      if (!emailUnique) {
        await firebaseHelper.updateDocument(CollectionNames.usersTable, userId, user.toMapConsultation());
        UI.showMessage("Profile updated Successfully");
      }
      loading.onUpdateData(false);
    } on Failure catch (e) {
      loading.onErrorState(e);
    }
  }

  customerUpdateProfile(String userId) async{
    if (!formKey.currentState!.validate()){
      return;
    }
    userCubit.onLoadingState();
    try{

      User user = User();
      user.id = userId;
      user.name = name.text;
      user.email = email.text;
      user.password = password.text;
      user.address = address.text;
      user.phone = phone.text;
      user.gender = selectedGender.state.data;
      user.dateOfBirth = dobirth.text;
      user.jobId = jobId.text;
      user.nationalId = nationalId.text;
      user.image = await Helper.fileToBase64(imageFile.state.data ?? File(""));
      user.type = 2;
      print("user.get() >>>>  ${user.toMap()}");
      loading.onUpdateData(true);
      bool emailUnique = await isEmailUnique(email.text);
      if (!emailUnique) {
        await firebaseHelper.updateDocument(CollectionNames.usersTable, userId, user.toMap());
        UI.showMessage("Profile updated Successfully");
      }
      loading.onUpdateData(false);
    } on Failure catch (e) {
      loading.onErrorState(e);
    }
  }

  Future getAllUserByType(int type) async{
    try{
      userCubit.onLoadingState();
      List<QueryDocumentSnapshot> result = await firebaseHelper.searchDocuments(CollectionNames.usersTable, "type", type);
      List<User> data = [];
      result.forEach((res){
        print(res.data());
        data.add(User.fromJson(res.data() as Map<String, dynamic>));
      });
      userByTypesCubit.onUpdateData(data);
    }catch (e){
      print("get user by id exception $e");
    }
  }
}