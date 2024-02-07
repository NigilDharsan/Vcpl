class VehicleModel {
  bool? success;
  List<Data>? data;
  String? message;

  VehicleModel({this.success, this.data, this.message});

  VehicleModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? vehicleName;
  String? vehicleNo;
  String? insuranceDate;
  int? iscompany;
  int? status;
  int? addedBy;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.vehicleName,
      this.vehicleNo,
      this.insuranceDate,
      this.iscompany,
      this.status,
      this.addedBy,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehicleName = json['vehicle_name'];
    vehicleNo = json['vehicle_no'];
    insuranceDate = json['insurance_date'];
    iscompany = json['iscompany'];
    status = json['status'];
    addedBy = json['added_by'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehicle_name'] = this.vehicleName;
    data['vehicle_no'] = this.vehicleNo;
    data['insurance_date'] = this.insuranceDate;
    data['iscompany'] = this.iscompany;
    data['status'] = this.status;
    data['added_by'] = this.addedBy;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
