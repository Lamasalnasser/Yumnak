import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:template/shared/models/user_model.dart';

class MissingModel {
  String? id;
  // 1 is missing persons
  // 2 another missing
  int? type;
  String? description;
  String? fullName;
  int? contactNumber;
  int? identifierNumber;
  String? image;
  DateTime? createTime;
  String? userId;
  UserModel? userData;

  MissingModel(
      {this.id,
        this.type,
        this.description,
        this.fullName,
        this.contactNumber,
        this.identifierNumber,
        this.image,
        this.userId,
        this.userData});

  MissingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    description = json['description'];
    fullName = json['full_name'];
    contactNumber = json['contact_number'];
    identifierNumber = json['identifier_number'];
    image = json['image'];
    createTime = (json['createTime'] as Timestamp).toDate();
    userId = json['user_id'];
    userData = json['user_data'] != null
        ? new UserModel.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['description'] = this.description;
    data['full_name'] = this.fullName;
    data['contact_number'] = this.contactNumber;
    data['identifier_number'] = this.identifierNumber;
    data['image'] = this.image;
    data['createTime'] = DateTime.now();
    data['user_id'] = this.userId;
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    return data;
  }
}