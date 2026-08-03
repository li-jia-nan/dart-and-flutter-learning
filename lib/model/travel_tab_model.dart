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
  final int type;
  final Article article;

  TravelItem({required this.type, required this.article});

  factory TravelItem.fromJson(Map<String, dynamic> json) =>
      TravelItem(type: json["type"], article: Article.fromJson(json["article"]));

  Map<String, dynamic> toJson() => {"type": type, "article": article.toJson()};
}

class Article {
  final int? articleId;
  final int productType;
  final dynamic sourceType;
  final String articleTitle;
  final String content;
  final dynamic contentWithoutCtag;
  final Author author;
  final List<Image> images;
  final bool hasVideo;
  final Video video;
  final int? readCount;
  final int likeCount;
  final int commentCount;
  final int? shareCount;

  Article({
    required this.articleId,
    required this.productType,
    required this.sourceType,
    required this.articleTitle,
    required this.content,
    required this.contentWithoutCtag,
    required this.author,
    required this.images,
    required this.hasVideo,
    required this.video,
    required this.readCount,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    articleId: json["articleId"],
    productType: json["productType"],
    sourceType: json["sourceType"],
    articleTitle: json["articleTitle"],
    content: json["content"],
    contentWithoutCtag: json["contentWithoutCtag"],
    author: Author.fromJson(json["author"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    hasVideo: json["hasVideo"],
    video: Video.fromJson(json["video"]),
    readCount: json["readCount"],
    likeCount: json["likeCount"],
    commentCount: json["commentCount"],
    shareCount: json["shareCount"],
  );

  Map<String, dynamic> toJson() => {
    "articleId": articleId,
    "productType": productType,
    "sourceType": sourceType,
    "articleTitle": articleTitle,
    "content": content,
    "contentWithoutCtag": contentWithoutCtag,
    "author": author.toJson(),
    "images": List<dynamic>.from(images.map((x) => x.toJson())),
    "hasVideo": hasVideo,
    "video": video.toJson(),
    "readCount": readCount,
    "likeCount": likeCount,
    "commentCount": commentCount,
    "shareCount": shareCount,
  };
}

class Author {
  final dynamic authorId;
  final String nickName;
  final String clientAuth;
  final String userUrl;
  final String jumpUrl;
  final CoverImage coverImage;
  final dynamic qualification;
  final dynamic tag;
  final dynamic followCount;
  final String vIcon;
  final dynamic levelValue;
  final dynamic levelValueText;
  final String identityDesc;
  final bool isStarAccount;

  Author({
    required this.authorId,
    required this.nickName,
    required this.clientAuth,
    required this.userUrl,
    required this.jumpUrl,
    required this.coverImage,
    required this.qualification,
    required this.tag,
    required this.followCount,
    required this.vIcon,
    required this.levelValue,
    required this.levelValueText,
    required this.identityDesc,
    required this.isStarAccount,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
    authorId: json["authorId"],
    nickName: json["nickName"],
    clientAuth: json["clientAuth"],
    userUrl: json["userUrl"],
    jumpUrl: json["jumpUrl"],
    coverImage: CoverImage.fromJson(json["coverImage"]),
    qualification: json["qualification"],
    tag: json["tag"],
    followCount: json["followCount"],
    vIcon: json["vIcon"],
    levelValue: json["levelValue"],
    levelValueText: json["levelValueText"],
    identityDesc: json["identityDesc"],
    isStarAccount: json["isStarAccount"],
  );

  Map<String, dynamic> toJson() => {
    "authorId": authorId,
    "nickName": nickName,
    "clientAuth": clientAuth,
    "userUrl": userUrl,
    "jumpUrl": jumpUrl,
    "coverImage": coverImage.toJson(),
    "qualification": qualification,
    "tag": tag,
    "followCount": followCount,
    "vIcon": vIcon,
    "levelValue": levelValue,
    "levelValueText": levelValueText,
    "identityDesc": identityDesc,
    "isStarAccount": isStarAccount,
  };
}

class CoverImage {
  final String dynamicUrl;
  final dynamic originalUrl;

  CoverImage({required this.dynamicUrl, required this.originalUrl});

  factory CoverImage.fromJson(Map<String, dynamic> json) =>
      CoverImage(dynamicUrl: json["dynamicUrl"], originalUrl: json["originalUrl"]);

  Map<String, dynamic> toJson() => {"dynamicUrl": dynamicUrl, "originalUrl": originalUrl};
}

class Image {
  final int imageId;
  final String dynamicUrl;
  final String originalUrl;
  final int width;
  final int height;
  final dynamic mediaType;
  final dynamic lat;
  final dynamic lon;
  final dynamic isWaterMarked;

  Image({
    required this.imageId,
    required this.dynamicUrl,
    required this.originalUrl,
    required this.width,
    required this.height,
    required this.mediaType,
    required this.lat,
    required this.lon,
    required this.isWaterMarked,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    imageId: json["imageId"],
    dynamicUrl: json["dynamicUrl"],
    originalUrl: json["originalUrl"],
    width: (json["width"] as num).toInt(),
    height: (json["height"] as num).toInt(),
    mediaType: json["mediaType"],
    lat: json["lat"],
    lon: json["lon"],
    isWaterMarked: json["isWaterMarked"],
  );

  Map<String, dynamic> toJson() => {
    "imageId": imageId,
    "dynamicUrl": dynamicUrl,
    "originalUrl": originalUrl,
    "width": width,
    "height": height,
    "mediaType": mediaType,
    "lat": lat,
    "lon": lon,
    "isWaterMarked": isWaterMarked,
  };
}

class Video {
  final int videoId;
  final String coverImageUrl;
  final String videoUrl;
  final dynamic mediaType;
  final int width;
  final int height;
  final int durationSeconds;

  Video({
    required this.videoId,
    required this.coverImageUrl,
    required this.videoUrl,
    required this.mediaType,
    required this.width,
    required this.height,
    required this.durationSeconds,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    videoId: json["videoId"],
    coverImageUrl: json["coverImageUrl"],
    videoUrl: json["videoUrl"],
    mediaType: json["mediaType"],
    width: (json["width"] as num).toInt(),
    height: (json["height"] as num).toInt(),
    durationSeconds: json["durationSeconds"],
  );

  Map<String, dynamic> toJson() => {
    "videoId": videoId,
    "coverImageUrl": coverImageUrl,
    "videoUrl": videoUrl,
    "mediaType": mediaType,
    "width": width,
    "height": height,
    "durationSeconds": durationSeconds,
  };
}
