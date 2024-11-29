class User {
  String? id;
  String? name;
  String? contact_info;
  String? company_name;
  String? email;
  String? phone;
  String? address;
  String? password;
  String? spcialization;
  int? type;
  String? image;
  String? gender;
  String? dateOfBirth;
  String? nationalId;
  String? jobId;
  // Unblocked
  // Blocked
  String? status;

  User({
    this.id,
    this.name,
    this.email,
    this.contact_info,
    this.company_name,
    this.phone,
    this.address,
    this.password,
    this.spcialization,
    this.type,
    this.image,
    this.gender,
    this.dateOfBirth,
    this.nationalId,
    this.jobId,
    this.status,
  });

  // Convert a Customer object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
      'type': type,
      "image": image,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "national_id": nationalId,
      "job_id": jobId,
      "status": status,
    };
  }

  // Convert a Customer object to a Map
  Map<String, dynamic> toMapLogin() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Convert a Supplier object to a Map
  Map<String, dynamic> toMapSupplier() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
      'type': type,
    };
  }

  // Convert a Consultation object to a Map
  Map<String, dynamic> toMapConsultation() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'spcialization': spcialization,
      'phone': phone,
      'address': address,
      'password': password,
      'type': type,
    };
  }


  // for saving data
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'contact_info': contact_info,
      'company_name': company_name,
      'address': address,
      'password': password,
      'spcialization': spcialization,
      'type': type,
      "image": image,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "national_id": nationalId,
      "job_id": jobId,
      "status": status,
    };
  }

  // Create a Customer object from a Map
  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      company_name: map['company_name'],
      contact_info: map['contact_info'],
      address: map['address'],
      password: map['password'],
      spcialization: map['spcialization'],
      type: map['type'],
      image: map['image'],
      gender: map['gender'],
      dateOfBirth: map['date_of_birth'],
      nationalId: map['national_id'],
      jobId: map['job_id'],
      status: map['status'] ?? "Unblocked",
    );
  }
}