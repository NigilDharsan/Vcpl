class PendingApprovalModel {
  bool? success;
  List<Data>? data;
  String? message;

  PendingApprovalModel({this.success, this.data, this.message});

  PendingApprovalModel.fromJson(Map<String, dynamic> json) {
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
  int? ctid;
  String? material;
  String? transactionType;
  String? createdAt;
  String? siteName;
  int? currentSiteId;
  int? toSiteId;
  int? materialId;
  int? quantity;

  Data(
      {this.ctid,
      this.material,
      this.transactionType,
      this.createdAt,
      this.siteName,
      this.currentSiteId,
      this.toSiteId,
      this.materialId,
      this.quantity});

  Data.fromJson(Map<String, dynamic> json) {
    ctid = json['ctid'];
    material = json['material'];
    transactionType = json['transaction_type'];
    createdAt = json['created_at'];
    siteName = json['site_name'];
    currentSiteId = json['current_site_id'];
    toSiteId = json['to_site_id'];
    materialId = json['material_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ctid'] = this.ctid;
    data['material'] = this.material;
    data['transaction_type'] = this.transactionType;
    data['created_at'] = this.createdAt;
    data['site_name'] = this.siteName;
    data['current_site_id'] = this.currentSiteId;
    data['to_site_id'] = this.toSiteId;
    data['material_id'] = this.materialId;
    data['quantity'] = this.quantity;
    return data;
  }
}
