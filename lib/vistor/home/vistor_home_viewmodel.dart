import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/features/vistor/home/models/MissingModel.dart';
import 'package:template/shared/constants/collection_names.dart';
import 'package:template/shared/generic_cubit/generic_cubit.dart';
import 'package:template/shared/network/firebase_helper.dart';
import 'package:template/shared/prefs/pref_manager.dart';
import 'package:template/shared/util/app_routes.dart';
import 'package:template/shared/util/helper.dart';
import 'package:template/shared/util/ui.dart';
import 'package:uuid/uuid.dart';

class VistorHomeViewModel{
  FirebaseHelper firebaseHelper = FirebaseHelper();
  GenericCubit<File?> imageFile = GenericCubit(null);
  GenericCubit<bool> loading = GenericCubit(false);
  GenericCubit<List<MissingModel>> missings = GenericCubit([]);

  final formKey = GlobalKey<FormState>();

  TextEditingController description = TextEditingController(text: "");
  TextEditingController fullName = TextEditingController(text: "");
  TextEditingController contact_number = TextEditingController(text: "");
  TextEditingController identifier_number = TextEditingController(text: "");

  // Function to pick an image from the device
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.onUpdateData(File(pickedFile.path));
    }
  }

  addMissing(int type) async{
    if (!formKey.currentState!.validate()){
      return;
    }

    if(imageFile.state.data == null){
      UI.showMessage("Upload missing image");
      return;
    }

    MissingModel serv = MissingModel();
    String missingId = Uuid().v4(); // Generate a unique ID for the service

    try {
      loading.onLoadingState();
      loading.onUpdateData(true);
      String urlImage = await Helper.fileToBase64(
          imageFile.state.data ?? File(""));

      serv.id = missingId;
      serv.fullName = fullName.text;
      serv.description = description.text;
      serv.contactNumber = int.parse(contact_number.text);
      serv.identifierNumber = int.parse(identifier_number.text);
      serv.image = urlImage;
      serv.type = type;
      serv.userId= PrefManager.currentUser?.id;
      serv.userData= PrefManager.currentUser;

      QuerySnapshot? querySnapshot = await firebaseHelper.addDocumentWithSpacificDocID(CollectionNames.missingsTable, missingId, serv.toJson());
      querySnapshot?.docs.forEach((e){
        print("e.data()");
        print(e.data());
      });
      UI.showMessage("Missing post added success");
      UI.push(AppRoutes.addingMissingSuccessfully, arguments: serv);
      getAllMissingsForEveryUserID();
      loading.onUpdateData(false);
    }catch (e){
      loading.onUpdateData(false);
      print("add Missing post exception  >>>   $e");
    }
  }

  fillData(MissingModel a) async{
    fullName.text = a.fullName!;
    contact_number.text = a.contactNumber.toString();
    description.text = a.description!;
    identifier_number.text = a.identifierNumber.toString();
    imageFile.onUpdateData(await Helper.base64ToFile(a.image!));
  }

  updateMissing(String missingId) async{
    if (!formKey.currentState!.validate()){
      return;
    }

    if(imageFile.state.data == null){
      UI.showMessage("Upload missing image");
      return;
    }

    MissingModel serv = MissingModel();
    try {
      loading.onLoadingState();
      loading.onUpdateData(true);
      String urlImage = await Helper.fileToBase64(imageFile.state.data ?? File(""));

      serv.id = missingId;
      serv.fullName = fullName.text;
      serv.description = description.text;
      serv.contactNumber = int.parse(contact_number.text);
      serv.identifierNumber = int.parse(identifier_number.text);
      serv.image = urlImage;
      serv.type = 1;
      serv.userId= PrefManager.currentUser?.id;
      serv.userData= PrefManager.currentUser;

      await firebaseHelper.updateDocument(CollectionNames.missingsTable, missingId, serv.toJson());
      UI.showMessage("Missing updated success");
      getAllMissingsForEveryUserID();
      loading.onUpdateData(false);
      UI.pop();
    }catch (e){
      loading.onUpdateData(false);
      print("update missing exception  >>>   $e");
    }
  }

  deleteMissing(String missingId) async{
    try {
      loading.onLoadingState();
      loading.onUpdateData(true);
      await firebaseHelper.deleteDocument(CollectionNames.missingsTable, missingId);
      UI.showMessage("Missing deleted success");
      if(PrefManager.currentUser?.type == 1) {
        UI.pushWithRemove(AppRoutes.vistorstartPage);
      }
      loading.onUpdateData(false);
    }catch (e){
      loading.onUpdateData(false);
      print("delete missing exception  >>>   $e");
    }
  }

  getAllMissingsForEveryUserID() async{
    try {
      missings.onLoadingState();
      List<QueryDocumentSnapshot> results = await firebaseHelper.searchDocuments(CollectionNames.missingsTable, "user_id", PrefManager.currentUser!.id);
      List<MissingModel> servs = [];
      results.forEach((res){
        print(res.data());
        servs.add(MissingModel.fromJson(res.data() as Map<String, dynamic>));
      });
      missings.onUpdateData(servs);
    }catch (e){
      missings.onUpdateData([]);
      print("missings exception  >>>   $e");
    }
  }

  getAllMissings() async{
    try {
      missings.onLoadingState();
      List<QueryDocumentSnapshot> results = await firebaseHelper.getAllDocuments(CollectionNames.missingsTable);
      List<MissingModel> servs = [];
      print("getAllmissings");
      results.forEach((res){
        print(res.data());
        servs.add(MissingModel.fromJson(res.data() as Map<String, dynamic>));
      });
      missings.onUpdateData(servs);
    }catch (e){
      missings.onUpdateData([]);
      print("all missings exception  >>>   $e");
    }
  }

}