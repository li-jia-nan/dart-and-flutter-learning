class TravelTabModel {
  final int code;
  final String message;
  final Data data;

  TravelTabModel({required this.code, required this.message, required this.data});

  factory TravelTabModel.fromJson(Map<String, dynamic> json) => TravelTabModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"code": code, "message": message, "data": data.toJson()};
}

class Data {
  final List<TravelTab> tabs;

  Data({required this.tabs});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(tabs: List<TravelTab>.from(json["tabs"].map((x) => TravelTab.fromJson(x))));

  Map<String, dynamic> toJson() => {"tabs": List<dynamic>.from(tabs.map((x) => x.toJson()))};
}

class TravelTab {
  final String labelName;
  final String groupChannelCode;

  TravelTab({required this.labelName, required this.groupChannelCode});

  factory TravelTab.fromJson(Map<String, dynamic> json) =>
      TravelTab(labelName: json["labelName"], groupChannelCode: json["groupChannelCode"]);

  Map<String, dynamic> toJson() => {"labelName": labelName, "groupChannelCode": groupChannelCode};
}
