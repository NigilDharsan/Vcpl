class LoginModel {
  bool? success;
  LoginData? data;
  String? message;

  LoginModel({this.success, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
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

class LoginData {
  String? token;
  String? error;
  int? userId;
  String? name;
  String? empCode;
  String? mobile;
  List<Permissions>? permissions;

  LoginData(
      {this.token,
      this.error,
      this.userId,
      this.name,
      this.empCode,
      this.mobile,
      this.permissions});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    error = json['error'];
    userId = json['user_id'];
    name = json['name'];
    empCode = json['emp_code'];
    mobile = json['mobile'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['error'] = this.error;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['emp_code'] = this.empCode;
    data['mobile'] = this.mobile;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  int? id;
  String? name;
  String? guardName;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Permissions(
      {this.id,
      this.name,
      this.guardName,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    guardName = json['guard_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['guard_name'] = this.guardName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? roleId;
  int? permissionId;

  Pivot({this.roleId, this.permissionId});

  Pivot.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    permissionId = json['permission_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_id'] = this.roleId;
    data['permission_id'] = this.permissionId;
    return data;
  }
}
