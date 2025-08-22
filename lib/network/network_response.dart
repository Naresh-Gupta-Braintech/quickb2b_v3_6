class NetworkResponse<T> {
  T? data;
  int? status;
  String? message;
  NetworkResponse({required this.status, required this.data, required this.message});

  factory NetworkResponse.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    return NetworkResponse<T>(message: json["message"], status: json["status"], data: json["data"] == null ? null : fromJsonT(json["data"]));
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T? data) toJsonT) => {"message": message, "status": status, "data": toJsonT(data)};
}

class NetworkResponse1 {
  String? data;
  bool? status;
  String? message;

  NetworkResponse1({required this.status, required this.data, required this.message});

  factory NetworkResponse1.fromJson(Map<String, dynamic> json) {
    return NetworkResponse1(message: json["message"], status: json["status"], data: json["data"]?.toString());
  }

  Map<String, dynamic> toJson() => {"message": message, "status": status, "data": data};
}

class NetworkResponse0<T> {
  List<T>? dataList;
  String? message;
  bool? status;
  NetworkResponse0({required this.status, required this.dataList, required this.message});

  factory NetworkResponse0.fromJson(Map<String, dynamic> json, T Function(dynamic json) fromJsonT) {
    return NetworkResponse0<T>(
      message: json["message"],
      status: json["status"],
      dataList: json["data"] == null ? null : List<T>.from(json["data"].map((data) => fromJsonT(data))),
    );
  }

  Map<String, dynamic> toJson(List<Map<String, dynamic>> Function(List<T>? dataList) toJsonT) => {
    "message": message,
    "status": status,
    "data": toJsonT(dataList),
  };
}
