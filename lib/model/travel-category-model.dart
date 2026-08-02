class TravelCategoryModel {
  final int code;
  final String message;
  final Data data;

  TravelCategoryModel({required this.code, required this.message, required this.data});

  factory TravelCategoryModel.fromJson(Map<String, dynamic> json) => TravelCategoryModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"code": code, "message": message, "data": data.toJson()};
}

class Data {
  final List<Tab> tabs;

  Data({required this.tabs});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(tabs: List<Tab>.from(json["tabs"].map((x) => Tab.fromJson(x))));

  Map<String, dynamic> toJson() => {"tabs": List<dynamic>.from(tabs.map((x) => x.toJson()))};
}

class Tab {
  final String labelName;
  final String groupChannelCode;

  Tab({required this.labelName, required this.groupChannelCode});

  factory Tab.fromJson(Map<String, dynamic> json) =>
      Tab(labelName: json["labelName"], groupChannelCode: json["groupChannelCode"]);

  Map<String, dynamic> toJson() => {"labelName": labelName, "groupChannelCode": groupChannelCode};
}
