class CommonModel {
  bool? success;
  Data? data;
  String? message;

  CommonModel({this.success, this.data, this.message});

  CommonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? ctid;
  String? toSiteId;
  String? quantity;
  String? transactionType;
  int? stock;
  String? materialId;

  Data(
      {this.ctid,
      this.toSiteId,
      this.quantity,
      this.transactionType,
      this.stock,
      this.materialId});

  Data.fromJson(Map<String, dynamic> json) {
    ctid = json['ctid'];
    toSiteId = json['to_site_id'];
    quantity = json['quantity'];
    transactionType = json['transaction_type'];
    stock = json['stock'];
    materialId = json['material_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ctid'] = this.ctid;
    data['to_site_id'] = this.toSiteId;
    data['quantity'] = this.quantity;
    data['transaction_type'] = this.transactionType;
    data['stock'] = this.stock;
    data['material_id'] = this.materialId;
    return data;
  }
}
