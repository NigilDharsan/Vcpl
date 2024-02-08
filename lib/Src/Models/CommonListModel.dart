class CommonListModel {
  bool? success;
  List<ListData>? data;
  String? message;

  CommonListModel({this.success, this.data, this.message});

  CommonListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null && json['data'] != []) {
      data = <ListData>[];
      json['data'].forEach((v) {
        data!.add(new ListData.fromJson(v));
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

class ListData {
  int? id;
  String? siteName;
  String? siteLocation;
  String? siteInchargeId;
  int? subContractorId;
  String? subContractor;
  int? status;
  String? createdAt;
  int? ctid;
  String? transactionType;
  int? quantity;
  int? currentSiteId;
  int? toSiteId;
  String? categoryName;
  String? productName;
  int? categoryId;
  int? subcategoryId;
  int? unitId;
  String? material;
  int? materialId;
  int labourCount = 0;

  ListData(
      {this.id,
      this.siteName,
      this.siteLocation,
      this.siteInchargeId,
      this.subContractorId,
      this.subContractor,
      this.status,
      this.createdAt,
      this.ctid,
      this.transactionType,
      this.quantity,
      this.currentSiteId,
      this.toSiteId,
      this.categoryName,
      this.productName,
      this.categoryId,
      this.subcategoryId,
      this.unitId,
      this.material,
      this.materialId,
      required this.labourCount});

  ListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    siteName = json['site_name'];
    siteLocation = json['site_location'];
    siteInchargeId = json['site_incharge_id'];
    subContractorId = json['sub_contractor_id'];
    subContractor = json['sub_contractor'];
    status = json['status'];
    createdAt = json['created_at'];
    ctid = json['ctid'];
    transactionType = json['transaction_type'];
    quantity = json['quantity'];
    currentSiteId = json['current_site_id'];
    toSiteId = json['to_site_id'];
    categoryName = json['category_name'];
    productName = json['product_name'];
    categoryId = json['category_id'];
    subcategoryId = json['subcategory_id'];
    unitId = json['unit_id'];
    material = json['material'];
    materialId = json['material_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_name'] = this.siteName;
    data['site_location'] = this.siteLocation;
    data['site_incharge_id'] = this.siteInchargeId;
    data['sub_contractor_id'] = this.subContractorId;
    data['sub_contractor'] = this.subContractor;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['ctid'] = this.ctid;
    data['transaction_type'] = this.transactionType;
    data['quantity'] = this.quantity;
    data['current_site_id'] = this.currentSiteId;
    data['to_site_id'] = this.toSiteId;
    data['category_name'] = this.categoryName;
    data['product_name'] = this.productName;
    data['category_id'] = this.categoryId;
    data['subcategory_id'] = this.subcategoryId;
    data['unit_id'] = this.unitId;
    data['material'] = this.material;
    data['material_id'] = this.materialId;
    return data;
  }
}
