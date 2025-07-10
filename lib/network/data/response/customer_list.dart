import 'dart:convert';

CustomersData customersListFromJson(String str) => CustomersData.fromJson(json.decode(str));

String customersListToJson(CustomersData data) => json.encode(data.toJson());

class CustomersData {
    List<SingleCustmer>? data;
    int? status;

    CustomersData({
        this.data,
        this.status,
    });

    factory CustomersData.fromJson(Map<String, dynamic> json) => CustomersData(
        data: json["data"] == null ? [] : List<SingleCustmer>.from(json["data"]!.map((x) => SingleCustmer.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "status": status,
    };
}

class SingleCustmer {
    String? customerCode;
    String? email;
    String? businessName;
    String? firstName;
    String? contactName;
    String? lastName;
    String? deliverySuburb;
    String? repName;
    int? isManager;

    SingleCustmer({
        this.customerCode,
        this.email,
        this.businessName,
        this.firstName,
        this.contactName,
        this.lastName,
        this.deliverySuburb,
        this.repName,
        this.isManager,
    });

    factory SingleCustmer.fromJson(Map<String, dynamic> json) => SingleCustmer(
        customerCode: json["customer_code"],
        email: json["email"],
        businessName: json["business_name"],
        firstName: json["first_name"],
        contactName: json["contact_name"],
        lastName: json["last_name"],
        deliverySuburb: json["delivery_suburb"],
        repName: json["rep_name"],
        isManager: json["isManager"],
    );

    Map<String, dynamic> toJson() => {
        "customer_code": customerCode,
        "email": email,
        "business_name": businessName,
        "first_name": firstName,
        "contact_name": contactName,
        "last_name": lastName,
        "delivery_suburb": deliverySuburb,
        "rep_name": repName,
        "isManager": isManager,
    };
}
