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
  final List<TravelItem> list;

  Data({required this.list});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(list: List<TravelItem>.from(json["list"].map((x) => TravelItem.fromJson(x))));

  Map<String, dynamic> toJson() => {"list": List<dynamic>.from(list.map((x) => x.toJson()))};
}

class TravelItem {
  final String article;

  TravelItem({required this.article});

  factory TravelItem.fromJson(Map<String, dynamic> json) => TravelItem(article: json["article"]);

  Map<String, dynamic> toJson() => {"article": article};
}
