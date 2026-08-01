// 搜索模型
class SearchModel {
  // 搜索关键字，非接口返回
  String? keyword;
  final int code;
  final String message;
  final List<SearchItem> data;

  SearchModel({required this.code, required this.message, required this.data});

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    code: json["code"],
    message: json["message"],
    data: List<SearchItem>.from(json["data"].map((x) => SearchItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SearchItem {
  final String code;
  final String word;
  final String type;
  final String price;
  final String zonename;
  final String star;
  final String districtName;
  final String url;

  SearchItem({
    required this.code,
    required this.word,
    required this.type,
    required this.price,
    required this.zonename,
    required this.star,
    required this.districtName,
    required this.url,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
    code: json["code"],
    word: json["word"],
    type: json["type"],
    price: json["price"],
    zonename: json["zonename"],
    star: json["star"],
    districtName: json["districtName"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "word": word,
    "type": type,
    "price": price,
    "zonename": zonename,
    "star": star,
    "districtName": districtName,
    "url": url,
  };
}
