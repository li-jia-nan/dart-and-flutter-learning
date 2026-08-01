class HomeModel {
  final int code;
  final String message;
  final Data data;

  HomeModel({required this.code, required this.message, required this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      HomeModel(code: json["code"], message: json["message"], data: Data.fromJson(json["data"]));

  Map<String, dynamic> toJson() => {"code": code, "message": message, "data": data.toJson()};
}

class Data {
  final Config config;
  final List<BannerList> bannerList;
  final List<LocalNavList> localNavList;
  final GridNav gridNav;
  final List<LocalNavList> subNavList;
  final SalesBox salesBox;

  Data({
    required this.config,
    required this.bannerList,
    required this.localNavList,
    required this.gridNav,
    required this.subNavList,
    required this.salesBox,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    config: Config.fromJson(json["config"]),
    bannerList: List<BannerList>.from(json["bannerList"].map((x) => BannerList.fromJson(x))),
    localNavList: List<LocalNavList>.from(
      json["localNavList"].map((x) => LocalNavList.fromJson(x)),
    ),
    gridNav: GridNav.fromJson(json["gridNav"]),
    subNavList: List<LocalNavList>.from(json["subNavList"].map((x) => LocalNavList.fromJson(x))),
    salesBox: SalesBox.fromJson(json["salesBox"]),
  );

  Map<String, dynamic> toJson() => {
    "config": config.toJson(),
    "bannerList": List<dynamic>.from(bannerList.map((x) => x.toJson())),
    "localNavList": List<dynamic>.from(localNavList.map((x) => x.toJson())),
    "gridNav": gridNav.toJson(),
    "subNavList": List<dynamic>.from(subNavList.map((x) => x.toJson())),
    "salesBox": salesBox.toJson(),
  };
}

class BannerList {
  final String icon;
  final String url;

  BannerList({required this.icon, required this.url});

  factory BannerList.fromJson(Map<String, dynamic> json) =>
      BannerList(icon: json["icon"], url: json["url"]);

  Map<String, dynamic> toJson() => {"icon": icon, "url": url};
}

class Config {
  final String searchUrl;

  Config({required this.searchUrl});

  factory Config.fromJson(Map<String, dynamic> json) => Config(searchUrl: json["searchUrl"]);

  Map<String, dynamic> toJson() => {"searchUrl": searchUrl};
}

class GridNav {
  final Flight hotel;
  final Flight flight;
  final Flight travel;

  GridNav({required this.hotel, required this.flight, required this.travel});

  factory GridNav.fromJson(Map<String, dynamic> json) => GridNav(
    hotel: Flight.fromJson(json["hotel"]),
    flight: Flight.fromJson(json["flight"]),
    travel: Flight.fromJson(json["travel"]),
  );

  Map<String, dynamic> toJson() => {
    "hotel": hotel.toJson(),
    "flight": flight.toJson(),
    "travel": travel.toJson(),
  };
}

class Flight {
  final String startColor;
  final String endColor;
  final LocalNavList mainItem;
  final LocalNavList item1;
  final LocalNavList item2;
  final LocalNavList item3;
  final LocalNavList item4;

  Flight({
    required this.startColor,
    required this.endColor,
    required this.mainItem,
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
  });

  factory Flight.fromJson(Map<String, dynamic> json) => Flight(
    startColor: json["startColor"],
    endColor: json["endColor"],
    mainItem: LocalNavList.fromJson(json["mainItem"]),
    item1: LocalNavList.fromJson(json["item1"]),
    item2: LocalNavList.fromJson(json["item2"]),
    item3: LocalNavList.fromJson(json["item3"]),
    item4: LocalNavList.fromJson(json["item4"]),
  );

  Map<String, dynamic> toJson() => {
    "startColor": startColor,
    "endColor": endColor,
    "mainItem": mainItem.toJson(),
    "item1": item1.toJson(),
    "item2": item2.toJson(),
    "item3": item3.toJson(),
    "item4": item4.toJson(),
  };
}

class LocalNavList {
  final String title;
  final String url;
  final String? statusBarColor;
  final bool? hideAppBar;
  final String? icon;

  LocalNavList({
    required this.title,
    required this.url,
    this.statusBarColor,
    this.hideAppBar,
    this.icon,
  });

  factory LocalNavList.fromJson(Map<String, dynamic> json) => LocalNavList(
    title: json["title"],
    url: json["url"],
    statusBarColor: json["statusBarColor"],
    hideAppBar: json["hideAppBar"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
    "statusBarColor": statusBarColor,
    "hideAppBar": hideAppBar,
    "icon": icon,
  };
}

class SalesBox {
  final String icon;
  final String moreUrl;
  final LocalNavList bigCard1;
  final LocalNavList bigCard2;
  final LocalNavList smallCard1;
  final LocalNavList smallCard2;
  final LocalNavList smallCard3;
  final LocalNavList smallCard4;

  SalesBox({
    required this.icon,
    required this.moreUrl,
    required this.bigCard1,
    required this.bigCard2,
    required this.smallCard1,
    required this.smallCard2,
    required this.smallCard3,
    required this.smallCard4,
  });

  factory SalesBox.fromJson(Map<String, dynamic> json) => SalesBox(
    icon: json["icon"],
    moreUrl: json["moreUrl"],
    bigCard1: LocalNavList.fromJson(json["bigCard1"]),
    bigCard2: LocalNavList.fromJson(json["bigCard2"]),
    smallCard1: LocalNavList.fromJson(json["smallCard1"]),
    smallCard2: LocalNavList.fromJson(json["smallCard2"]),
    smallCard3: LocalNavList.fromJson(json["smallCard3"]),
    smallCard4: LocalNavList.fromJson(json["smallCard4"]),
  );

  Map<String, dynamic> toJson() => {
    "icon": icon,
    "moreUrl": moreUrl,
    "bigCard1": bigCard1.toJson(),
    "bigCard2": bigCard2.toJson(),
    "smallCard1": smallCard1.toJson(),
    "smallCard2": smallCard2.toJson(),
    "smallCard3": smallCard3.toJson(),
    "smallCard4": smallCard4.toJson(),
  };
}
