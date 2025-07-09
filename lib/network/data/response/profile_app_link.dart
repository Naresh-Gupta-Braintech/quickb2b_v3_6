import 'dart:convert';

ProfileAppLinkModel profileAppLinkFromJson(String str) => ProfileAppLinkModel.fromJson(json.decode(str));

String profileAppLinkToJson(ProfileAppLinkModel data) => json.encode(data.toJson());

class ProfileAppLinkModel {
  int? status;
  String? message;
  Data? data;

  ProfileAppLinkModel({this.status, this.message, this.data});

  factory ProfileAppLinkModel.fromJson(Map<String, dynamic> json) => ProfileAppLinkModel(status: json["status"], message: json["message"], data: json["data"] == null ? null : Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data?.toJson()};
}

class Data {
  List<Pdf>? websites;
  List<Pdf>? pdf;
  List<dynamic>? links;
  String? statementEmail;
  int? repFlag;
  Representatives? representatives;

  Data({this.websites, this.pdf, this.links, this.statementEmail, this.repFlag, this.representatives});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    websites: json["websites"] == null ? [] : List<Pdf>.from(json["websites"]!.map((x) => Pdf.fromJson(x))),
    pdf: json["pdf"] == null ? [] : List<Pdf>.from(json["pdf"]!.map((x) => Pdf.fromJson(x))),
    links: json["links"] == null ? [] : List<dynamic>.from(json["links"]!.map((x) => x)),
    statementEmail: json["statementEmail"],
    repFlag: json["repFlag"],
    representatives: json["representatives"] == null ? null : Representatives.fromJson(json["representatives"]),
  );

  Map<String, dynamic> toJson() => {
    "websites": websites == null ? [] : List<dynamic>.from(websites!.map((x) => x.toJson())),
    "pdf": pdf == null ? [] : List<dynamic>.from(pdf!.map((x) => x.toJson())),
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x)),
    "statementEmail": statementEmail,
    "repFlag": repFlag,
    "representatives": representatives?.toJson(),
  };
}

class Pdf {
  String? type;
  String? title;
  String? link;

  Pdf({this.type, this.title, this.link});

  factory Pdf.fromJson(Map<String, dynamic> json) => Pdf(type: json["type"], title: json["title"], link: json["link"]);

  Map<String, dynamic> toJson() => {"type": type, "title": title, "link": link};
}

class Representatives {
  String? email;
  String? phone;

  Representatives({this.email, this.phone});

  factory Representatives.fromJson(Map<String, dynamic> json) => Representatives(email: json["email"], phone: json["phone"]);

  Map<String, dynamic> toJson() => {"email": email, "phone": phone};
}
